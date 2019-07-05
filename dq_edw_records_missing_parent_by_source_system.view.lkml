view: dq_edw_records_missing_parent_by_source_system {
  #Make sure stage table process_timestamp look back days are in sync with event table looks back days.
  derived_table: {
    sql: SELECT SCENARIO, TABLE_NAME, CHAIN_ID, NHIN_STORE_ID, ID, SOURCE_SYSTEM_ID, SOURCE_TIMESTAMP
      FROM
      (
        --SQL to check if any dirver table is missing the corresponding parent records
        select distinct 'Transaction without a prescription' as scenario,
               'EDW.F_RX_TX_LINK' as table_name,
               src.chain_id,
               src.nhin_store_id,
               cast(src.rx_tx_id as string) as id,
               src.source_system_id,
               src.source_timestamp
          from edw.f_rx_tx_link src,
          (select chain_id, source_system_id, min(event_id) min_event_id, max(event_id) max_event_id,
                  min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
            from (
                   select ejc.chain_id,
                          ej.event_id,
                          case when ej.job_name like '%PDX%' then 11
                               when ej.job_name like '%EPS%' then 4
                          end source_system_id,
                          min(ejc.process_data_begin_date) as min_process_timestamp,
                          max(ejc.process_data_end_date) as max_process_timestamp,
                          count(distinct ej.job_name) as cnt
                          from etl_manager.event e,
                               etl_manager.event_job ej,
                               etl_manager.event_job_chain ejc
                          where e.status = 'S'
                          and e.event_type = 'STAGE TO EDW ETL'
                          and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                          and e.event_id = ej.event_id
                          --Added job names to consider event_ids ran specific to below jobs.
                          and ej.job_name in ('JOB_EPS_RX_EDW', 'JOB_EPS_RX_TX_LINK_EDW', 'JOB_PDX_RX_EDW', 'JOB_PDX_RX_TX_LINK_EDW')
                          and ej.event_id = ejc.event_id
                          and ej.job_name = ejc.job_name
                        group by 1,2,3
                 )
            where cnt = 2 --consider events processed both workflow_history and rx_tx records for a source system.
            group by 1,2
          ) e
          where {% condition chain.chain_id %} src.chain_id {% endcondition %}
            and {% condition store.nhin_store_id %} src.nhin_store_id {% endcondition %}
            and src.rx_id           is not null
            and src.event_id        >= e.min_event_id
            and src.event_id        <= e.max_event_id
            and src.chain_id         = e.chain_id
            and src.source_system_id = e.source_system_id
            and not exists (select null
                              from json_stage.symmetric_event_stage
                                where table_name = 'RX_SUMMARY'
                                and (((event_data:RX_SOURCE):: varchar):: number(2,0)) = 21 --informational prescription.
                                and chain_id           = e.chain_id
                                and process_timestamp >= dateadd(day, -2, current_date())
                                and process_timestamp >= e.min_process_timestamp
                                and process_timestamp < e.max_process_timestamp
                                and chain_id           = src.chain_id
                                and nhin_store_id      = src.nhin_store_id
                                and (((event_data:ID)::varchar)::number(38,0)) = src.rx_id)
            and not exists (select null
                              from edw.f_rx
                              where chain_id         = src.chain_id
                                and nhin_store_id    = src.nhin_store_id
                                and rx_id            = src.rx_id
                                and source_system_id = src.source_system_id)
        union all
        select distinct 'Prescription without a patient' as scenario,
               'EDW.F_RX' as table_name,
               src.chain_id,
               src.nhin_store_id,
               cast(src.rx_id as string) as id,
               src.source_system_id,
               src.source_timestamp
          from edw.f_rx src,
          (select chain_id, source_system_id, min(event_id) min_event_id, max(event_id) max_event_id
            from (
                  select ejc.chain_id, ej.event_id,
                    case when ej.job_name like '%PDX%' then 11
                         when ej.job_name like '%EPS%' then 4
                    end source_system_id,
                    count(distinct ej.job_name) as cnt
                    from etl_manager.event e,
                         etl_manager.event_job ej,
                         etl_manager.event_job_chain ejc
                    where e.status = 'S'
                    and e.event_type = 'STAGE TO EDW ETL'
                    and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                    and e.event_id = ej.event_id
                    --Added job names to consider event_ids ran specific to below jobs.
                    and ej.job_name in ('JOB_EPS_RX_EDW', 'JOB_EPS_STORE_PATIENT_EDW', 'JOB_PDX_RX_EDW', 'JOB_PDX_STORE_PATIENT_EDW')
                    and ej.event_id = ejc.event_id
                    and ej.job_name = ejc.job_name
                  group by 1,2,3
                 )
            where cnt = 2 --consider events processed both rx and patient records for a source system.
            group by 1,2
          ) e
          where {% condition chain.chain_id %} src.chain_id {% endcondition %}
            and {% condition store.nhin_store_id %} src.nhin_store_id {% endcondition %}
            and src.rx_patient_id   is not null
            and src.event_id        >= e.min_event_id
            and src.event_id        <= e.max_event_id
            and src.chain_id         = e.chain_id
            and src.source_system_id = e.source_system_id
            and not exists (select null
                              from edw.d_store_patient
                              where chain_id         = src.chain_id
                                and nhin_store_id    = src.nhin_store_id
                                and patient_id       = src.rx_patient_id
                                and source_system_id = src.source_system_id)
        union all
        select distinct 'Claim without a transaction' as scenario,
               'EDW.F_TX_TP_LINK' as table_name,
               src.chain_id,
               src.nhin_store_id,
               cast(src.tx_tp_id as string) as id,
               src.source_system_id,
               src.source_timestamp
          from edw.f_tx_tp_link src,
          (select chain_id, source_system_id, min(event_id) min_event_id, max(event_id) max_event_id
            from (
                  select ejc.chain_id, ej.event_id,
                    case when ej.job_name like '%PDX%' then 11
                         when ej.job_name like '%EPS%' then 4
                    end source_system_id,
                    count(distinct ej.job_name) as cnt
                    from etl_manager.event e,
                         etl_manager.event_job ej,
                         etl_manager.event_job_chain ejc
                    where e.status = 'S'
                    and e.event_type = 'STAGE TO EDW ETL'
                    and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                    and e.event_id = ej.event_id
                    --Added job names to consider event_ids ran specific to below jobs.
                    and ej.job_name in ('JOB_EPS_RX_TX_LINK_EDW', 'JOB_EPS_TX_TP_LINK_EDW', 'JOB_PDX_RX_TX_LINK_EDW', 'JOB_PDX_TX_TP_LINK_EDW')
                    and ej.event_id = ejc.event_id
                    and ej.job_name = ejc.job_name
                  group by 1,2,3
                 )
            where cnt = 2 --consider events processed both tx_tp and rx_tx records for a source system.
            group by 1,2
          ) e
          where {% condition chain.chain_id %} src.chain_id {% endcondition %}
            and {% condition store.nhin_store_id %} src.nhin_store_id {% endcondition %}
            and src.rx_tx_id         is not null
            and src.event_id        >= e.min_event_id
            and src.event_id        <= e.max_event_id
            and src.chain_id         = e.chain_id
            and src.source_system_id = e.source_system_id
            and not exists (select null
                              from edw.f_rx_tx_link
                              where chain_id         = src.chain_id
                                and nhin_store_id    = src.nhin_store_id
                                and rx_tx_id         = src.rx_tx_id
                                and source_system_id = src.source_system_id)
        union all
        select distinct 'Transmit Queue without Claim' as scenario,
               'EDW.F_TX_TP_TRANSMIT_QUEUE' as table_name,
               src.chain_id,
               src.nhin_store_id,
               cast(src.tx_tp_transmit_queue_id as string) as id,
               src.source_system_id,
               src.source_timestamp
          from edw.f_tx_tp_transmit_queue src,
          (select chain_id, source_system_id, min(event_id) min_event_id, max(event_id) max_event_id
            from (
                  select ejc.chain_id, ej.event_id,
                    case when ej.job_name like '%PDX%' then 11
                         when ej.job_name like '%EPS%' then 4
                    end source_system_id,
                    count(distinct ej.job_name) as cnt
                    from etl_manager.event e,
                         etl_manager.event_job ej,
                         etl_manager.event_job_chain ejc
                    where e.status = 'S'
                    and e.event_type = 'STAGE TO EDW ETL'
                    and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                    and e.event_id = ej.event_id
                    --Added job names to consider event_ids ran specific to below jobs.
                    and ej.job_name in ('JOB_EPS_TX_TP_TRANSMIT_QUEUE_EDW', 'JOB_EPS_TX_TP_LINK_EDW')
                    and ej.event_id = ejc.event_id
                    and ej.job_name = ejc.job_name
                  group by 1,2,3
                 )
            where cnt = 2 --consider events processed both tx_tp and tx_tp_transmit_queue records for a source system.
            group by 1,2
          ) e
          where {% condition chain.chain_id %} src.chain_id {% endcondition %}
            and {% condition store.nhin_store_id %} src.nhin_store_id {% endcondition %}
            and src.tx_tp_id         is not null
            and src.event_id        >= e.min_event_id
            and src.event_id        <= e.max_event_id
            and src.chain_id         = e.chain_id
            and src.source_system_id = e.source_system_id
            and not exists (select null
                              from edw.f_tx_tp_link
                              where chain_id         = src.chain_id
                                and nhin_store_id    = src.nhin_store_id
                                and tx_tp_id         = src.tx_tp_id
                                and source_system_id = src.source_system_id)
        union all
        select distinct 'Line item without an Order Entry' as scenario,
               'EDW.F_LINE_ITEM' as table_name,
               src.chain_id,
               src.nhin_store_id,
               cast(src.line_item_id as string) as id,
               src.source_system_id,
               src.source_timestamp
          from edw.f_line_item src,
          (select chain_id, source_system_id, min(event_id) min_event_id, max(event_id) max_event_id
            from (
                  select ejc.chain_id, ej.event_id,
                    case when ej.job_name like '%PDX%' then 11
                         when ej.job_name like '%EPS%' then 4
                    end source_system_id,
                    count(distinct ej.job_name) as cnt
                    from etl_manager.event e,
                         etl_manager.event_job ej,
                         etl_manager.event_job_chain ejc
                    where e.status = 'S'
                    and e.event_type = 'STAGE TO EDW ETL'
                    and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                    and e.event_id = ej.event_id
                    --Added job names to consider event_ids ran specific to below jobs.
                    and ej.job_name in ('JOB_EPS_LINE_ITEM_EDW', 'JOB_EPS_ORDER_ENTRY_EDW')
                    and ej.event_id = ejc.event_id
                    and ej.job_name = ejc.job_name
                  group by 1,2,3
                 )
            where cnt = 2 --consider events processed both line_item and order_entry records for a source system.
            group by 1,2
          ) e
          where {% condition chain.chain_id %} src.chain_id {% endcondition %}
            and {% condition store.nhin_store_id %} src.nhin_store_id {% endcondition %}
            and src.line_item_order_entry_id is not null
            and src.event_id        >= e.min_event_id
            and src.event_id        <= e.max_event_id
            and src.chain_id         = e.chain_id
            and src.source_system_id = e.source_system_id
            and not exists (select null
                              from edw.f_order_entry
                              where chain_id         = src.chain_id
                                and nhin_store_id    = src.nhin_store_id
                                and order_entry_id   = src.line_item_order_entry_id
                                and source_system_id = src.source_system_id)
        union all
        select distinct 'Workflow History without a Transaction' as scenario,
               'EDW.F_WORKFLOW_HISTORY' as table_name,
               src.chain_id,
               src.nhin_store_id,
               cast(src.workflow_history_id as string) as id,
               src.source_system_id,
               src.source_timestamp
          from edw.f_workflow_history src,
          (select chain_id, source_system_id, min(event_id) min_event_id, max(event_id) max_event_id,
                  min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
            from (
                   select ejc.chain_id,
                          ej.event_id,
                          case when ej.job_name like '%PDX%' then 11
                               when ej.job_name like '%EPS%' then 4
                          end source_system_id,
                          min(ejc.process_data_begin_date) as min_process_timestamp,
                          max(ejc.process_data_end_date) as max_process_timestamp,
                          count(distinct ej.job_name) as cnt
                          from etl_manager.event e,
                               etl_manager.event_job ej,
                               etl_manager.event_job_chain ejc
                          where e.status = 'S'
                          and e.event_type = 'STAGE TO EDW ETL'
                          and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                          and e.event_id = ej.event_id
                          --Added job names to consider event_ids ran specific to below jobs.
                          and ej.job_name in ('JOB_EPS_WORKFLOW_HISTORY_EDW', 'JOB_EPS_RX_TX_LINK_EDW')
                          and ej.event_id = ejc.event_id
                          and ej.job_name = ejc.job_name
                        group by 1,2,3
                 )
            where cnt = 2 --consider events processed both workflow_history and rx_tx records for a source system.
            group by 1,2
          ) e
          where {% condition chain.chain_id %} src.chain_id {% endcondition %}
            and {% condition store.nhin_store_id %} src.nhin_store_id {% endcondition %}
            and src.line_item_id is not null
            and src.event_id        >= e.min_event_id
            and src.event_id        <= e.max_event_id
            and src.chain_id         = e.chain_id
            and src.source_system_id = e.source_system_id
            and not exists (select null
                              from json_stage.symmetric_event_stage
                                where table_name = 'RX_TX'
                                and (((event_data:NHIN_STORE_ID) :: varchar) :: number(10,0)) != nhin_store_id --informational tx
                                and chain_id           = e.chain_id
                                and process_timestamp >= dateadd(day, -2, current_date())
                                and process_timestamp >= e.min_process_timestamp
                                and process_timestamp < e.max_process_timestamp
                                and chain_id           = src.chain_id
                                and nhin_store_id      = src.nhin_store_id
                                and (((event_data:ID) :: varchar) :: number(38,0)) = src.line_item_id)
            and not exists (select null
                              from edw.f_rx_tx_link
                              where chain_id         = src.chain_id
                                and nhin_store_id    = src.nhin_store_id
                                and rx_tx_id         = src.line_item_id
                                and source_system_id = src.source_system_id)
        union all
        select distinct 'Task History without a Transaction' as scenario,
               'EDW.F_TASK_HISTORY' as table_name,
               src.chain_id,
               src.nhin_store_id,
               cast(src.task_history_id as string) as id,
               src.source_system_id,
               src.source_timestamp
          from edw.f_task_history src,
          (select chain_id, source_system_id, min(event_id) min_event_id, max(event_id) max_event_id,
                  min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
            from (
                   select ejc.chain_id,
                          ej.event_id,
                          case when ej.job_name like '%PDX%' then 11
                               when ej.job_name like '%EPS%' then 4
                          end source_system_id,
                          min(ejc.process_data_begin_date) as min_process_timestamp,
                          max(ejc.process_data_end_date) as max_process_timestamp,
                          count(distinct ej.job_name) as cnt
                          from etl_manager.event e,
                               etl_manager.event_job ej,
                               etl_manager.event_job_chain ejc
                          where e.status = 'S'
                          and e.event_type = 'STAGE TO EDW ETL'
                          and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                          and e.event_id = ej.event_id
                          --Added job names to consider event_ids ran specific to below jobs.
                          and ej.job_name in ('JOB_EPS_TASK_HISTORY_EDW', 'JOB_EPS_RX_TX_LINK_EDW')
                          and ej.event_id = ejc.event_id
                          and ej.job_name = ejc.job_name
                        group by 1,2,3
                 )
            where cnt = 2 --consider events processed both task_history and rx_tx records for a source system.
            group by 1,2
          ) e
          where src.line_item_id is not null
            and src.event_id        >= e.min_event_id
            and src.event_id        <= e.max_event_id
            and src.chain_id         = e.chain_id
            and src.source_system_id = e.source_system_id
            and not exists (select null
                              from json_stage.symmetric_event_stage
                                where table_name = 'RX_TX'
                                and (((event_data:NHIN_STORE_ID) :: varchar) :: number(10,0)) != nhin_store_id --informational tx
                                and chain_id           = e.chain_id
                                and process_timestamp >= dateadd(day, -2, current_date())
                                and process_timestamp >= e.min_process_timestamp
                                and process_timestamp < e.max_process_timestamp
                                and chain_id           = src.chain_id
                                and nhin_store_id      = src.nhin_store_id
                                and (((event_data:ID) :: varchar) :: number(38,0)) = src.line_item_id)
            and not exists (select null
                              from edw.f_rx_tx_link
                              where chain_id         = src.chain_id
                                and nhin_store_id    = src.nhin_store_id
                                and rx_tx_id         = src.line_item_id
                                and source_system_id = src.source_system_id)
        union all
        select distinct 'Prescription without a Drug' as scenario,
               'EDW.F_RX_TX_LINK' as table_name,
               src.chain_id,
               src.nhin_store_id,
               cast(src.rx_tx_id as string) as id,
               src.source_system_id,
               src.source_timestamp
          from edw.f_rx_tx_link src,
          (select chain_id, source_system_id, min(event_id) min_event_id, max(event_id) max_event_id
            from (
                  select ejc.chain_id, ej.event_id,
                    case when ej.job_name like '%PDX%' then 11
                         when ej.job_name like '%EPS%' then 4
                    end source_system_id,
                    count(distinct ej.job_name) as cnt
                    from etl_manager.event e,
                         etl_manager.event_job ej,
                         etl_manager.event_job_chain ejc
                    where e.status = 'S'
                    and e.event_type = 'STAGE TO EDW ETL'
                    and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                    and e.event_id = ej.event_id
                    --Added job names to consider event_ids ran specific to below jobs.
                    and ej.job_name in ('JOB_EPS_STORE_DRUG_EDW', 'JOB_EPS_RX_TX_LINK_EDW')
                    and ej.event_id = ejc.event_id
                    and ej.job_name = ejc.job_name
                  group by 1,2,3
                 )
            where cnt = 2 --consider events processed both drug and rx_tx records for a source system.
            group by 1,2
          ) e
          where {% condition chain.chain_id %} src.chain_id {% endcondition %}
            and {% condition store.nhin_store_id %} src.nhin_store_id {% endcondition %}
            and src.rx_tx_drug_dispensed_id is not null
            and src.event_id        >= e.min_event_id
            and src.event_id        <= e.max_event_id
            and src.chain_id         = e.chain_id
            and src.source_system_id = e.source_system_id
            and not exists (select null
                              from edw.d_store_drug
                              where chain_id         = src.chain_id
                                and nhin_store_id    = src.nhin_store_id
                                and drug_id          = src.rx_tx_drug_dispensed_id
                                and source_system_id = src.source_system_id)
        union all
        select distinct 'Drug Local Setting without a Drug' as scenario,
               'EDW.F_DRUG_LOCAL_SETTING' as table_name,
               src.chain_id,
               src.nhin_store_id,
               cast(src.drug_id as string) as id,
               src.source_system_id,
               src.source_timestamp
          from edw.f_drug_local_setting src,
          (select chain_id, source_system_id, min(event_id) min_event_id, max(event_id) max_event_id
            from (
                  select ejc.chain_id, ej.event_id,
                    case when ej.job_name like '%PDX%' then 11
                         when ej.job_name like '%EPS%' then 4
                    end source_system_id,
                    count(distinct ej.job_name) as cnt
                    from etl_manager.event e,
                         etl_manager.event_job ej,
                         etl_manager.event_job_chain ejc
                    where e.status = 'S'
                    and e.event_type = 'STAGE TO EDW ETL'
                    and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                    and e.event_id = ej.event_id
                    --Added job names to consider event_ids ran specific to below jobs.
                    and ej.job_name in ('JOB_EPS_STORE_DRUG_EDW', 'JOB_EPS_DRUG_LOCAL_STORE_SETTING_EDW')
                    and ej.event_id = ejc.event_id
                    and ej.job_name = ejc.job_name
                  group by 1,2,3
                 )
            where cnt = 2 --consider events processed both drug and drug_locaL_setting records for a source system.
            group by 1,2
          ) e
          where {% condition chain.chain_id %} src.chain_id {% endcondition %}
            and {% condition store.nhin_store_id %} src.nhin_store_id {% endcondition %}
            and src.drug_id is not null
            and src.event_id        >= e.min_event_id
            and src.event_id        <= e.max_event_id
            and src.chain_id         = e.chain_id
            and src.source_system_id = e.source_system_id
            and not exists (select null
                              from edw.d_store_drug
                              where chain_id         = src.chain_id
                                and nhin_store_id    = src.nhin_store_id
                                and drug_id          = to_char(src.drug_id)
                                and source_system_id = src.source_system_id)
        union all
        select distinct 'Transaction without a Prescriber Clinic Link' as scenario,
               'EDW.F_RX_TX_LINK' as table_name,
               src.chain_id,
               src.nhin_store_id,
               cast(src.rx_tx_id as string) as id,
               src.source_system_id,
               src.source_timestamp
          from edw.f_rx_tx_link src,
          (select chain_id, source_system_id, min(event_id) min_event_id, max(event_id) max_event_id
            from (
                  select ejc.chain_id, ej.event_id,
                    case when ej.job_name like '%PDX%' then 11
                         when ej.job_name like '%EPS%' then 4
                    end source_system_id,
                    count(distinct ej.job_name) as cnt
                    from etl_manager.event e,
                         etl_manager.event_job ej,
                         etl_manager.event_job_chain ejc
                    where e.status = 'S'
                    and e.event_type = 'STAGE TO EDW ETL'
                    and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                    and e.event_id = ej.event_id
                    --Added job names to consider event_ids ran specific to below jobs.
                    and ej.job_name in ('JOB_EPS_RX_TX_LINK_EDW', 'JOB_EPS_STORE_PRESCRIBER_CLINIC_LINK_EDW')
                    and ej.event_id = ejc.event_id
                    and ej.job_name = ejc.job_name
                  group by 1,2,3
                 )
            where cnt = 2 --consider events processed both prescriber_clinic_link and rx_tx records for a source system.
            group by 1,2
          ) e
          where {% condition chain.chain_id %} src.chain_id {% endcondition %}
            and {% condition store.nhin_store_id %} src.nhin_store_id {% endcondition %}
            and src.rx_tx_presc_clinic_link_id is not null
            and src.event_id        >= e.min_event_id
            and src.event_id        <= e.max_event_id
            and src.chain_id         = e.chain_id
            and src.source_system_id = e.source_system_id
            and not exists (select null
                              from edw.d_store_prescriber_clinic_link
                              where chain_id                   = src.chain_id
                                and nhin_store_id              = src.nhin_store_id
                                and store_prescriber_clinic_link_id = src.rx_tx_presc_clinic_link_id
                                and source_system_id           = src.source_system_id)
        union all
        select distinct 'Drug Cost without a Drug' as scenario,
               'EDW.D_STORE_DRUG_COST' as table_name,
               src.chain_id,
               src.nhin_store_id,
               cast(src.drug_cost_id as string) as id,
               src.source_system_id,
               src.source_timestamp
          from edw.d_store_drug_cost src,
          (select chain_id, source_system_id, min(event_id) min_event_id, max(event_id) max_event_id
            from (
                  select ejc.chain_id, ej.event_id,
                    case when ej.job_name like '%PDX%' then 11
                         when ej.job_name like '%EPS%' then 4
                    end source_system_id,
                    count(distinct ej.job_name) as cnt
                    from etl_manager.event e,
                         etl_manager.event_job ej,
                         etl_manager.event_job_chain ejc
                    where e.status = 'S'
                    and e.event_type = 'STAGE TO EDW ETL'
                    and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                    and e.event_id = ej.event_id
                    --Added job names to consider event_ids ran specific to below jobs.
                    and ej.job_name in ('JOB_EPS_STORE_DRUG_COST_EDW', 'JOB_EPS_STORE_DRUG_EDW')
                    and ej.event_id = ejc.event_id
                    and ej.job_name = ejc.job_name
                  group by 1,2,3
                 )
            where cnt = 2 --consider events processed both drug and drug_cost records for a source system.
            group by 1,2
          ) e
          where {% condition chain.chain_id %} src.chain_id {% endcondition %}
            and {% condition store.nhin_store_id %} src.nhin_store_id {% endcondition %}
            and src.drug_id         is not null
            and src.event_id        >= e.min_event_id
            and src.event_id        <= e.max_event_id
            and src.chain_id         = e.chain_id
            and src.source_system_id = e.source_system_id
            and not exists (select null
                              from edw.d_store_drug
                              where chain_id         = src.chain_id
                                and nhin_store_id    = src.nhin_store_id
                                and drug_id          = to_char(src.drug_id)
                                and source_system_id = src.source_system_id)
      ) edw_records_missing_parent
       ;;
  }

  dimension: scenario {
    label: "Missing Records Scenario"
    type: string
    sql: ${TABLE}.SCENARIO ;;
  }

  dimension: id {
    label: "Source Table Unique Identifier"
    type: string
    sql: ${TABLE}.ID ;;
  }

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    type: string
    sql: ${scenario}||'@'||${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${id}||'@'||${source_system_id} ;; #ERXLPS-1649
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

  dimension: table_name {
    type: string
    sql: ${TABLE}.TABLE_NAME ;;
  }

  dimension: source_system_id {
    hidden: yes
    type: number
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  #####################################################################################################################################################################################################################

  ########################################################################################################### DATE/TIME specific Fields ################################################################################
  dimension_group: source {
    label: "Source"
    description: "Date record was inserted/updated in source"
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
    sql: ${TABLE}.SOURCE_TIMESTAMP ;;
  }

  ################################################################################################### Measures ############################################################

  measure: count {
    type: count
    value_format: "#,###"
    drill_fields: [detail*]
  }

  ################################################################################### End of Measures ################################################################################

  set: detail {
    fields: [
      chain.chain_name,
      store.store_number,
      store.store_name,
      scenario,
      table_name,
      chain.chain_id,
      store.nhin_store_id,
      id,
      source_system_id,
      source_time
    ]
  }
}

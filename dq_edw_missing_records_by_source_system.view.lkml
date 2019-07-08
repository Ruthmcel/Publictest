view: dq_edw_missing_records_by_source_system {
  derived_table: {
    sql: SELECT CHAIN_ID,NHIN_STORE_ID,ID,SOURCE_TIMESTAMP,PROCESS_TIMESTAMP,TARGET_TABLE,SOURCE_SYSTEM_ID
      FROM
      (SELECT DISTINCT CHAIN_ID,NHIN_ID AS NHIN_STORE_ID,CAST( ID AS VARCHAR) AS ID,SOURCE_TIMESTAMP,PROCESS_TIMESTAMP,'F_RX_TX' AS TARGET_TABLE, 3 AS SOURCE_SYSTEM_ID
      FROM EPR_STAGE.RX_TX_STAGE SRC
      WHERE NOT EXISTS (SELECT * FROM EDW.F_RX_TX TGT
                        WHERE SRC.CHAIN_ID = TGT.CHAIN_ID AND
                              SRC.ID = TGT.RX_TX_ID)

      UNION ALL

      SELECT DISTINCT CHAIN_ID,NHIN_ID AS NHIN_STORE_ID,CAST( ID AS VARCHAR) AS ID,SOURCE_TIMESTAMP,PROCESS_TIMESTAMP,'F_RX_TX_CRED' AS TARGET_TABLE, 3 AS SOURCE_SYSTEM_ID
      FROM EPR_STAGE.TX_CRED_STAGE SRC
      WHERE NOT EXISTS (SELECT * FROM EDW.F_RX_TX_CRED TGT
                        WHERE SRC.CHAIN_ID = TGT.CHAIN_ID AND
                              SRC.ID = TGT.RX_TX_CRED_ID)

      UNION ALL

      SELECT DISTINCT CHAIN_ID,NHIN_ID AS NHIN_STORE_ID,CAST( ID AS VARCHAR) AS ID,SOURCE_TIMESTAMP,PROCESS_TIMESTAMP,'F_RX_TX_DIAGNOSIS_CODE' AS TARGET_TABLE, 3 AS SOURCE_SYSTEM_ID
      FROM EPR_STAGE.RX_TX_DIAGNOSIS_CODES_STAGE SRC
      WHERE NOT EXISTS (SELECT * FROM EDW.F_RX_TX_DIAGNOSIS_CODE TGT
                        WHERE SRC.CHAIN_ID = TGT.CHAIN_ID AND
                              SRC.ID = TGT.RX_TX_DIAGNOSIS_CODE_ID)


      UNION ALL

      SELECT DISTINCT CHAIN_ID,NULL AS NHIN_STORE_ID,CAST( ID AS VARCHAR) AS ID,SOURCE_TIMESTAMP,PROCESS_TIMESTAMP,'F_TX_LOT_NUMBER' AS TARGET_TABLE, 3 AS SOURCE_SYSTEM_ID
      FROM EPR_STAGE.TX_LOT_STAGE SRC
      WHERE NOT EXISTS (SELECT * FROM EDW.F_TX_LOT_NUMBER TGT
                        WHERE SRC.CHAIN_ID = TGT.CHAIN_ID AND
                              SRC.ID = TGT.TX_LOT_NUMBER_ID)
      UNION ALL

      SELECT DISTINCT CHAIN_ID,NHIN_ID AS NHIN_STORE_ID,CAST( ID AS VARCHAR) AS ID,SOURCE_TIMESTAMP,PROCESS_TIMESTAMP,'F_TX_TP' AS TARGET_TABLE, 3 AS SOURCE_SYSTEM_ID
      FROM EPR_STAGE.TX_TP_STAGE SRC
      WHERE NOT EXISTS (SELECT * FROM EDW.F_TX_TP TGT
                        WHERE SRC.CHAIN_ID = TGT.CHAIN_ID AND
                              SRC.ID = TGT.TX_TP_ID)

       UNION ALL

      SELECT DISTINCT CHAIN_ID,NHIN_ID AS NHIN_STORE_ID,CAST( ID AS VARCHAR) AS ID,SOURCE_TIMESTAMP,PROCESS_TIMESTAMP,'D_PRESCRIBER' AS TARGET_TABLE, 3 AS SOURCE_SYSTEM_ID
      FROM EPR_STAGE.PRESCRIBER_STAGE SRC
      WHERE NOT EXISTS (SELECT * FROM EDW.D_PRESCRIBER TGT
                        WHERE SRC.CHAIN_ID = TGT.CHAIN_ID AND
                              SRC.ID = TGT.PRESCRIBER_ID)

      UNION ALL

      SELECT DISTINCT CHAIN_ID,NHIN_ID AS NHIN_STORE_ID,CAST( ID AS VARCHAR) AS ID,SOURCE_TIMESTAMP,PROCESS_TIMESTAMP,'D_ALT_PRESCRIBER' AS TARGET_TABLE, 3 AS SOURCE_SYSTEM_ID
      FROM EPR_STAGE.ALT_PRESCRIBER_STAGE SRC
      WHERE NOT EXISTS (SELECT * FROM EDW.D_ALT_PRESCRIBER TGT
                        WHERE SRC.CHAIN_ID = TGT.CHAIN_ID AND
                              SRC.ID = TGT.ALT_PRESCRIBER_ID)

      UNION ALL

      SELECT DISTINCT CHAIN_ID,NULL AS NHIN_STORE_ID,CAST( ID AS VARCHAR) AS ID,SOURCE_TIMESTAMP,PROCESS_TIMESTAMP,'D_PATIENT' AS TARGET_TABLE, 3 AS SOURCE_SYSTEM_ID
      FROM EPR_STAGE.PATIENT_STAGE SRC
      WHERE NOT EXISTS (SELECT * FROM EDW.D_PATIENT TGT
                        WHERE SRC.CHAIN_ID = TGT.CHAIN_ID AND
                              SRC.ID = TGT.RX_COM_ID  )

      UNION ALL

      SELECT DISTINCT CHAIN_ID,NULL AS NHIN_STORE_ID,CAST( ID AS VARCHAR) AS ID,SOURCE_TIMESTAMP,PROCESS_TIMESTAMP,'D_PATIENT_ALLERGY' AS TARGET_TABLE, 3 AS SOURCE_SYSTEM_ID
      FROM EPR_STAGE.ALLERGY_STAGE SRC
      WHERE NOT EXISTS (SELECT * FROM EDW.D_PATIENT_ALLERGY TGT
                        WHERE SRC.CHAIN_ID = TGT.CHAIN_ID AND
                              SRC.ID_PATIENT = TGT.RX_COM_ID AND
                              SRC.AC_CODE = TGT.PATIENT_ALLERGY_CODE  )
      UNION ALL

      SELECT DISTINCT CHAIN_ID,NULL AS NHIN_STORE_ID,CAST( ID AS VARCHAR) AS ID,SOURCE_TIMESTAMP,PROCESS_TIMESTAMP,'D_PATIENT_DISEASE' AS TARGET_TABLE, 3 AS SOURCE_SYSTEM_ID
      FROM EPR_STAGE.DISEASE_STAGE SRC
      WHERE NOT EXISTS (SELECT * FROM EDW.D_PATIENT_DISEASE TGT
                        WHERE SRC.CHAIN_ID = TGT.CHAIN_ID AND
                              SRC.ID_PATIENT = TGT.RX_COM_ID AND
                              SRC.ID = TGT.DISEASE_ID  )

      UNION ALL

      SELECT DISTINCT CHAIN_ID,NULL AS NHIN_STORE_ID,CAST( ID AS VARCHAR) AS ID,SOURCE_TIMESTAMP,PROCESS_TIMESTAMP,'D_PATIENT_MEDICAL_CONDITION' AS TARGET_TABLE, 3 AS SOURCE_SYSTEM_ID
      FROM EPR_STAGE.MEDICAL_CONDITION_STAGE SRC
      WHERE NOT EXISTS (SELECT * FROM EDW.D_PATIENT_MEDICAL_CONDITION TGT
                        WHERE SRC.CHAIN_ID = TGT.CHAIN_ID AND
                              SRC.ID_PATIENT = TGT.RX_COM_ID AND
                              SRC.ID = TGT.MEDICAL_CONDITION_ID  )

      UNION ALL

      SELECT DISTINCT CHAIN_ID,NULL AS NHIN_STORE_ID,CAST( ID AS VARCHAR) AS ID,SOURCE_TIMESTAMP,PROCESS_TIMESTAMP,'D_PATIENT_MTM_ELIGIBILITY' AS TARGET_TABLE, 3 AS SOURCE_SYSTEM_ID
      FROM EPR_STAGE.MTM_PATIENT_ELIGIBILITY_STAGE SRC
      WHERE NOT EXISTS (SELECT * FROM EDW.D_PATIENT_MTM_ELIGIBILITY TGT
                        WHERE SRC.CHAIN_ID = TGT.CHAIN_ID AND
                              SRC.RX_COM_ID = TGT.RX_COM_ID AND
                              SRC.ID = TGT.PATIENT_MTM_ID  )

      UNION ALL

      SELECT DISTINCT CHAIN_ID,NULL AS NHIN_STORE_ID,CAST( ID AS VARCHAR) AS ID,SOURCE_TIMESTAMP,PROCESS_TIMESTAMP,'D_PATIENT_PHONE' AS TARGET_TABLE, 3 AS SOURCE_SYSTEM_ID
      FROM EPR_STAGE.TELEPHONE_STAGE SRC
      WHERE NOT EXISTS (SELECT * FROM EDW.D_PATIENT_PHONE TGT
                        WHERE SRC.CHAIN_ID = TGT.CHAIN_ID AND
                              SRC.ID_PATIENT = TGT.RX_COM_ID AND
                              SRC.LOCATION_TYPE = TGT.PATIENT_PHONE_LOCATION_TYPE )
      UNION ALL

      SELECT DISTINCT CHAIN_ID,NULL AS NHIN_STORE_ID,CAST( ID AS VARCHAR) AS ID,SOURCE_TIMESTAMP,PROCESS_TIMESTAMP,'D_PATIENT_ADDRESS' AS TARGET_TABLE, 3 AS SOURCE_SYSTEM_ID
      FROM EPR_STAGE.ADDRESS_STAGE SRC
      WHERE NOT EXISTS (SELECT * FROM EDW.D_PATIENT_ADDRESS TGT
                        WHERE SRC.CHAIN_ID = TGT.CHAIN_ID AND
                              SRC.ID_PATIENT = TGT.RX_COM_ID AND
                              SRC.ID = TGT.PATIENT_ADDRESS_ID  )

      UNION ALL

      SELECT DISTINCT CHAIN_ID,NULL AS NHIN_STORE_ID,CAST( ID AS VARCHAR) AS ID,SOURCE_TIMESTAMP,PROCESS_TIMESTAMP,'D_PATIENT_EMAIL' AS TARGET_TABLE, 3 AS SOURCE_SYSTEM_ID
      FROM EPR_STAGE.EMAIL_STAGE SRC
      WHERE NOT EXISTS (SELECT * FROM EDW.D_PATIENT_EMAIL TGT
                        WHERE SRC.CHAIN_ID = TGT.CHAIN_ID AND
                              SRC.ID_PATIENT = TGT.RX_COM_ID AND
                              SRC.EMAIL_ADDRESS = TGT.PATIENT_EMAIL_ADDRESS  )

      --------------------------------------------------------------------------------------- MDS ----------------------------------------------------------------------------------------------------------------------
      UNION ALL

      SELECT DISTINCT NULL CHAIN_ID,NULL NHIN_STORE_ID,CAST( ID AS VARCHAR) AS ID,SOURCE_TIMESTAMP,PROCESS_TIMESTAMP,'D_PROGRAM' AS TARGET_TABLE, 7 AS SOURCE_SYSTEM_ID
      FROM MDS_STAGE.PROGRAM_STAGE SRC
      WHERE NOT EXISTS (SELECT * FROM EDW.D_PROGRAM TGT
                        WHERE SRC.CODE = TGT.PROGRAM_CODE)

      UNION ALL

      SELECT DISTINCT NULL CHAIN_ID,NULL NHIN_STORE_ID,CAST( ID AS VARCHAR) AS ID,SOURCE_TIMESTAMP,PROCESS_TIMESTAMP,'D_DOCUMENT' AS TARGET_TABLE, 7 AS SOURCE_SYSTEM_ID
      FROM MDS_STAGE.DOCUMENTS_STAGE SRC
      WHERE NOT EXISTS (SELECT * FROM EDW.D_DOCUMENT TGT
                        WHERE SRC.DOCUMENTID = TGT.DOCUMENT_IDENTIFIER)

      UNION ALL

      SELECT DISTINCT NULL CHAIN_ID,NHINID AS NHIN_STORE_ID,CAST( ID AS VARCHAR) AS ID,SOURCE_TIMESTAMP,PROCESS_TIMESTAMP,'F_TRANSACTION' AS TARGET_TABLE, 7 AS SOURCE_SYSTEM_ID
      FROM MDS_STAGE.TRANSACTIONS_STAGE SRC
      WHERE NOT EXISTS (SELECT * FROM EDW.F_TRANSACTION TGT
                        WHERE SRC.ID = TGT.TRANSACTION_ID)

      UNION ALL

      SELECT DISTINCT NULL CHAIN_ID,NULL NHIN_STORE_ID,CAST( ID AS VARCHAR) AS ID,SOURCE_TIMESTAMP,PROCESS_TIMESTAMP,'F_PRINT_TRANSACTION' AS TARGET_TABLE, 7 AS SOURCE_SYSTEM_ID
      FROM MDS_STAGE.PRINT_TRANSACTIONS_STAGE SRC
      WHERE NOT EXISTS (SELECT * FROM EDW.F_PRINT_TRANSACTION TGT
                        WHERE SRC.ID = TGT.PRINT_TRANSACTION_ID)

      UNION ALL

      SELECT DISTINCT NULL CHAIN_ID, NHINID AS NHIN_STORE_ID,CAST( ID AS VARCHAR) AS ID,SOURCE_TIMESTAMP,PROCESS_TIMESTAMP,'D_PROGRAM_GPI' AS TARGET_TABLE, 7 AS SOURCE_SYSTEM_ID
      FROM MDS_STAGE.GPIS_STAGE SRC
      WHERE NOT EXISTS (SELECT * FROM EDW.D_PROGRAM_GPI TGT
                        WHERE SRC.GPI = TGT.GPI AND
                                      SRC.NHINID = TGT.NHIN_STORE_ID)

      UNION ALL

      SELECT DISTINCT NULL CHAIN_ID, NULL AS NHIN_STORE_ID,CAST( ID AS VARCHAR) AS ID,SOURCE_TIMESTAMP,PROCESS_TIMESTAMP,'D_GPI_UPDATE' AS TARGET_TABLE, 7 AS SOURCE_SYSTEM_ID
      FROM MDS_STAGE.GPI_UPDATE_STAGE SRC
      WHERE NOT EXISTS (SELECT * FROM EDW.D_GPI_UPDATE TGT
                        WHERE SRC.ID = TGT.GPI_UPDATE_ID)

      UNION ALL

      SELECT DISTINCT NULL CHAIN_ID, NULL AS NHIN_STORE_ID,CAST( ID AS VARCHAR) AS ID,SOURCE_TIMESTAMP,PROCESS_TIMESTAMP,'D_DRUG_UPDATE' AS TARGET_TABLE, 7 AS SOURCE_SYSTEM_ID
      FROM MDS_STAGE.NDC_UPDATE_STAGE SRC
      WHERE NOT EXISTS (SELECT * FROM EDW.D_DRUG_UPDATE TGT
                        WHERE SRC.ID = TGT.DRUG_UPDATE_ID)

      UNION ALL

      SELECT DISTINCT NULL CHAIN_ID, NULL AS NHIN_STORE_ID,CAST( ID AS VARCHAR) AS ID,SOURCE_TIMESTAMP,PROCESS_TIMESTAMP,'D_DRUG_EXCLUSION' AS TARGET_TABLE, 7 AS SOURCE_SYSTEM_ID
      FROM MDS_STAGE.NDC_EXCLUSION_STAGE SRC
      WHERE NOT EXISTS (SELECT * FROM EDW.D_DRUG_EXCLUSION TGT
                        WHERE SRC.NDC = TGT.NDC)

      UNION ALL

      SELECT DISTINCT NULL CHAIN_ID, NHINID AS NHIN_STORE_ID,CAST( ID AS VARCHAR) AS ID,SOURCE_TIMESTAMP,PROCESS_TIMESTAMP,'D_PROGRAM_FILE_UPDATE' AS TARGET_TABLE, 7 AS SOURCE_SYSTEM_ID
      FROM MDS_STAGE.FILE_UPDATE_STAGE SRC
      WHERE NOT EXISTS (SELECT * FROM EDW.D_PROGRAM_FILE_UPDATE TGT
                        WHERE SRC.NHINID = TGT.NHIN_STORE_ID AND
                                       SRC.VENDOR_ID = TGT.VENDOR_ID AND
                                       SRC.SERVICE_TYPE = TGT.PROGRAM_FILE_UPDATE_SERVICE_TYPE AND
                                       SRC.DOCUMENT_NAME = TGT.PROGRAM_FILE_UPDATE_DOCUMENT_NAME)

      UNION ALL

      SELECT DISTINCT NULL CHAIN_ID, NULL AS NHIN_STORE_ID,CAST( ID AS VARCHAR) AS ID,SOURCE_TIMESTAMP,PROCESS_TIMESTAMP,'D_ICU_FILE' AS TARGET_TABLE, 7 AS SOURCE_SYSTEM_ID
      FROM MDS_STAGE.ICU_FILES_STAGE SRC
      WHERE NOT EXISTS (SELECT * FROM EDW.D_ICU_FILE TGT
                        WHERE SRC.FILEID = TGT.ICU_FILE_IDENTIFIER)

      UNION ALL

      SELECT DISTINCT CHAIN_ID,NULL NHIN_STORE_ID,CAST(DRUG_NDC AS VARCHAR) AS ID,SOURCE_TIMESTAMP,PROCESS_TIMESTAMP,'D_DRUG' AS TARGET_TABLE, 0 AS SOURCE_SYSTEM_ID
      FROM HOST_CDC_STAGE.DRUG SRC
      WHERE NOT EXISTS (SELECT * FROM EDW.D_DRUG TGT
                        WHERE SRC.CHAIN_ID = TGT.CHAIN_ID AND
                              SRC.DRUG_NDC = TGT.NDC AND
                              SRC.SOURCE_SYSTEM_ID = TGT.SOURCE_SYSTEM_ID)
      AND EXISTS(SELECT NULL
                   FROM ETL_MANAGER.INBOUND_FILE_LOG IFL
                  WHERE SRC.CHAIN_ID                    = IFL.CHAIN_ID
                    AND SRC.FILE_ID                     = IFL.FILE_ID
                    AND NVL(IFL.IS_FILE_INVALID, 'N') = 'N'
                )

      UNION ALL

      SELECT DISTINCT CHAIN_ID,NULL NHIN_STORE_ID,CAST(CONCAT(CONCAT(CONCAT(CONCAT(DRUG_COST_REGION,'-'),DRUG_COST_NDC),'-'),DRUG_COST_TYPE) AS VARCHAR) AS ID,SOURCE_TIMESTAMP,PROCESS_TIMESTAMP,'D_DRUG_COST' AS TARGET_TABLE, 0 AS SOURCE_SYSTEM_ID
      FROM HOST_CDC_STAGE.DRUG_COST SRC
      WHERE NOT EXISTS (SELECT * FROM EDW.D_DRUG_COST TGT
                        WHERE SRC.CHAIN_ID = TGT.CHAIN_ID AND
                              SRC.DRUG_COST_REGION = TGT.DRUG_COST_REGION AND
                              SRC.DRUG_COST_NDC = TGT.NDC AND
                              SRC.DRUG_COST_TYPE = TGT.DRUG_COST_TYPE AND
                              SRC.SOURCE_SYSTEM_ID = TGT.SOURCE_SYSTEM_ID)
      AND EXISTS(SELECT NULL
                   FROM ETL_MANAGER.INBOUND_FILE_LOG IFL
                  WHERE SRC.CHAIN_ID                    = IFL.CHAIN_ID
                    AND SRC.FILE_ID                     = IFL.FILE_ID
                    AND NVL(IFL.IS_FILE_INVALID, 'N') = 'N'
                )

      UNION ALL

      SELECT DISTINCT CHAIN_ID,NULL NHIN_STORE_ID,CAST(DRUG_COST_TYPE AS VARCHAR) AS ID,SOURCE_TIMESTAMP,PROCESS_TIMESTAMP,'D_DRUG_COST_TYPE' AS TARGET_TABLE, 0 AS SOURCE_SYSTEM_ID
      FROM HOST_CDC_STAGE.DRUG_COST_TYPE SRC
      WHERE NOT EXISTS (SELECT * FROM EDW.D_DRUG_COST_TYPE TGT
                        WHERE SRC.CHAIN_ID = TGT.CHAIN_ID AND
                              SRC.DRUG_COST_TYPE = TGT.DRUG_COST_TYPE AND
                              SRC.SOURCE_SYSTEM_ID = TGT.SOURCE_SYSTEM_ID)
      AND EXISTS(SELECT NULL
                   FROM ETL_MANAGER.INBOUND_FILE_LOG IFL
                  WHERE SRC.CHAIN_ID                    = IFL.CHAIN_ID
                    AND SRC.FILE_ID                     = IFL.FILE_ID
                    AND NVL(IFL.IS_FILE_INVALID, 'N') = 'N'
                )

      UNION ALL

      SELECT DISTINCT CHAIN_ID,NULL NHIN_STORE_ID,CAST(CONCAT(CONCAT(CONCAT(CONCAT(PLAN_CARRIER_CODE,'-'),PLAN_CODE),'-'),PLAN_GROUP_CODE) AS VARCHAR) AS ID,SOURCE_TIMESTAMP,PROCESS_TIMESTAMP,'D_PLAN' AS TARGET_TABLE, 0 AS SOURCE_SYSTEM_ID
      FROM HOST_CDC_STAGE.PLAN SRC
      WHERE NOT EXISTS (SELECT * FROM EDW.D_PLAN TGT
                        WHERE SRC.CHAIN_ID = TGT.CHAIN_ID AND
                              SRC.PLAN_CARRIER_CODE = TGT.CARRIER_CODE AND
                              NVL(SRC.PLAN_CODE,'@##@') = NVL(TGT.PLAN_CODE,'@##@') AND
                              NVL(SRC.PLAN_GROUP_CODE,'@##@') = NVL(TGT.PLAN_GROUP_CODE,'@##@'))
      AND EXISTS(SELECT NULL
                   FROM ETL_MANAGER.INBOUND_FILE_LOG IFL
                  WHERE SRC.CHAIN_ID                    = IFL.CHAIN_ID
                    AND SRC.FILE_ID                     = IFL.FILE_ID
                    AND NVL(IFL.IS_FILE_INVALID, 'N') = 'N'
                )
      UNION ALL

      SELECT DISTINCT CHAIN_ID,NULL NHIN_STORE_ID,CAST(GPI AS VARCHAR) AS ID,SOURCE_TIMESTAMP,PROCESS_TIMESTAMP,'D_GPI' AS TARGET_TABLE, 0 AS SOURCE_SYSTEM_ID
      FROM HOST_CDC_STAGE.GPI SRC
      WHERE NOT EXISTS (SELECT * FROM EDW.D_GPI TGT
                        WHERE SRC.CHAIN_ID = TGT.CHAIN_ID AND
                              SRC.GPI = TGT.GPI AND
                              SRC.SOURCE_SYSTEM_ID = TGT.SOURCE_SYSTEM_ID)
      AND EXISTS(SELECT NULL
                   FROM ETL_MANAGER.INBOUND_FILE_LOG IFL
                  WHERE SRC.CHAIN_ID                    = IFL.CHAIN_ID
                    AND SRC.FILE_ID                     = IFL.FILE_ID
                    AND NVL(IFL.IS_FILE_INVALID, 'N') = 'N'
                )

      UNION ALL

      SELECT DISTINCT CHAIN_ID,NULL NHIN_STORE_ID,CAST(STORE_LICENSE_NAME AS VARCHAR) AS ID,SOURCE_TIMESTAMP,PROCESS_TIMESTAMP,'D_STORE_LICENSE' AS TARGET_TABLE, 0 AS SOURCE_SYSTEM_ID
      FROM HOST_CDC_STAGE.STORE_LICENSE SRC
      WHERE NOT EXISTS (SELECT * FROM EDW.D_STORE_LICENSE TGT
                        WHERE SRC.CHAIN_ID = TGT.CHAIN_ID AND
                              SRC.NHIN_STORE_ID = TGT.NHIN_STORE_ID AND
                              SRC.STORE_LICENSE_NAME = TGT.STORE_LICENSE_NAME AND
                              SRC.SOURCE_SYSTEM_ID = TGT.SOURCE_SYSTEM_ID)
      AND EXISTS(SELECT NULL
                   FROM ETL_MANAGER.INBOUND_FILE_LOG IFL
                  WHERE SRC.CHAIN_ID                    = IFL.CHAIN_ID
                    AND SRC.FILE_ID                     = IFL.FILE_ID
                    AND NVL(IFL.IS_FILE_INVALID, 'N') = 'N'
                )

      UNION ALL

      SELECT DISTINCT CHAIN_ID,NULL NHIN_STORE_ID,USER_LOGIN AS ID,SOURCE_TIMESTAMP,PROCESS_TIMESTAMP,'D_USER' AS TARGET_TABLE, 0 AS SOURCE_SYSTEM_ID
      FROM HOST_CDC_STAGE.USERS SRC
      WHERE NOT EXISTS (SELECT * FROM EDW.D_USER TGT
                        WHERE SRC.CHAIN_ID = TGT.CHAIN_ID AND
                              SRC.NHIN_STORE_ID = TGT.NHIN_STORE_ID AND
                              SRC.USER_LOGIN = TGT.USER_LOGIN AND
                              SRC.SOURCE_SYSTEM_ID = TGT.SOURCE_SYSTEM_ID)
      AND EXISTS(SELECT NULL
                   FROM ETL_MANAGER.INBOUND_FILE_LOG IFL
                  WHERE SRC.CHAIN_ID                    = IFL.CHAIN_ID
                    AND SRC.FILE_ID                     = IFL.FILE_ID
                    AND NVL(IFL.IS_FILE_INVALID, 'N') = 'N'
                )

      --new logic added
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             cast(s.event_data:DATA_FEED_LAST_UPDATE_DATE as timestamp_ntz(6)) as source_timestamp,
             s.process_timestamp,
             'D_ADDRESS' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_ADDRESS_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'ADDRESS'
        and s.dml_operation_type in ('I','U')
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null from edw.d_address
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(address_id) = cast(s.event_data:ID as string)
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             cast(s.event_data:DATA_FEED_LAST_UPDATE_DATE as timestamp_ntz(6)) as source_timestamp,
             s.process_timestamp,
             'D_ADJUSTMENT_CODE' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_ADJUSTMENT_CODE_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'ADJUSTMENT_CODES'
        and s.dml_operation_type in ('I','U')
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.d_adjustment_code
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(adjustment_code_id) = cast(s.event_data:ID as string)
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             s.source_timestamp,
             s.process_timestamp,
             'D_ADJUSTMENT_GROUP' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_ADJUSTMENT_GROUP_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'ADJUSTMENT_GROUP'
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.d_adjustment_group
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(adjustment_group_id) = cast(s.event_data:ID as string)
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             cast(s.event_data:SOURCE_TIMESTAMP as timestamp_ntz(6)) as source_timestamp,
             s.process_timestamp,
             'F_APPLICATION_EXCEPTION' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_APPLICATION_EXCEPTION_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'APPLICATION_EXCEPTIONS'
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.f_application_exception
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(application_exception_id) = cast(s.event_data:ID as string)
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             cast(s.event_data:SOURCE_TIMESTAMP as timestamp_ntz(6)) as source_timestamp,
             s.process_timestamp,
             'F_STORE_CALL_INSURANCE' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_STORE_CALL_INSURANCE_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'CALL_INSURANCE'
        and s.dml_operation_type in ('I','U')
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.f_store_call_insurance
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(store_call_insurance_id) = cast(s.event_data:ID as string)
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             cast(s.event_data:SOURCE_TIMESTAMP as timestamp_ntz(6)) as source_timestamp,
             s.process_timestamp,
             'F_STORE_CALL_INSURANCE_CONTACT' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_STORE_CALL_INSURANCE_CONTACT_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'CALL_INSURANCE_CONTACT'
        and s.dml_operation_type in ('I','U')
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.f_store_call_insurance_contact
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(store_call_insurance_contact_id) = cast(s.event_data:ID as string)
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             cast(s.event_data:SOURCE_TIMESTAMP as timestamp_ntz(6)) as source_timestamp,
             s.process_timestamp,
             'F_STORE_CALL_PATIENT' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_STORE_CALL_PATIENT_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'CALL_PATIENT'
        and s.dml_operation_type in ('I','U')
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.f_store_call_patient
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(store_call_patient_id) = cast(s.event_data:ID as string)
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             cast(s.event_data:SOURCE_TIMESTAMP as timestamp_ntz(6)) as source_timestamp,
             s.process_timestamp,
             'F_STORE_CALL_PATIENT_CONTACT' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_STORE_CALL_PATIENT_CONTACT_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'CALL_PATIENT_CONTACT'
        and s.dml_operation_type in ('I','U')
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.f_store_call_patient_contact
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(store_call_patient_contact_id) = cast(s.event_data:ID as string)
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             cast(s.event_data:SOURCE_TIMESTAMP as timestamp_ntz(6)) as source_timestamp,
             s.process_timestamp,
             'F_STORE_CALL_PHARMACY' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_STORE_CALL_PHARMACY_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'CALL_PHARMACY'
        and s.dml_operation_type in ('I','U')
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.f_store_call_pharmacy
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(store_call_pharmacy_id) = cast(s.event_data:ID as string)
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             cast(s.event_data:SOURCE_TIMESTAMP as timestamp_ntz(6)) as source_timestamp,
             s.process_timestamp,
             'F_STORE_CALL_PRESCRIBER' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_STORE_CALL_PRESCRIBER_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'CALL_PRESCRIBER'
        and s.dml_operation_type in ('I','U')
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.f_store_call_prescriber
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(store_call_prescriber_id) = cast(s.event_data:ID as string)
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             cast(s.event_data:SOURCE_TIMESTAMP as timestamp_ntz(6)) as source_timestamp,
             s.process_timestamp,
             'F_STORE_CALL_PRESCRIBER_CONTACT' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_STORE_CALL_PRESCRIBER_CONTACT_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'CALL_PRESCRIBER_CONTACT'
        and s.dml_operation_type in ('I','U')
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.f_store_call_prescriber_contact
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(store_call_prescriber_contact_id) = cast(s.event_data:ID as string)
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             cast(s.event_data:DATA_FEED_LAST_UPDATE_DATE as timestamp_ntz(6)) as source_timestamp,
             s.process_timestamp,
             'D_STORE_CARD' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_STORE_CARD_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'CARD'
        and s.dml_operation_type in ('I','U')
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.d_store_card
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(card_id) = cast(s.event_data:ID as string)
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             cast(s.event_data:DATA_FEED_LAST_UPDATE_DATE as timestamp_ntz(6)) as source_timestamp,
             s.process_timestamp,
             'F_CENTRAL_FILL' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_CENTRAL_FILL_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'CENTRAL_FILL'
        and s.dml_operation_type in ('I','U')
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.f_central_fill
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(central_fill_id) = cast(s.event_data:ID as string)
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             s.source_timestamp,
             s.process_timestamp,
             'F_PERPETUAL_INVENTORY_TRACKING' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_PERPETUAL_INVENTORY_TRACKING_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'CII_INVENTORY_TRACKING'
        and s.dml_operation_type in ('I','U')
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.f_perpetual_inventory_tracking
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(perpetual_inventory_tracking_id) = cast(s.event_data:ID as string)
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             cast(event_data:DATA_FEED_LAST_UPDATE_DATE as timestamp_ntz(6)) as source_timestamp,
             s.process_timestamp,
             'D_CLINIC' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_CLINIC_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'CLINIC'
        and s.dml_operation_type in ('I','U')
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.d_clinic
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(clinic_id) = cast(s.event_data:ID as string)
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             cast(event_data:SOURCE_TIMESTAMP as timestamp_ntz(6)) as source_timestamp,
             s.process_timestamp,
             'D_STORE_CLINICAL_TRACK' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_STORE_CLINICAL_TRACK_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'CLINICAL_TRACK'
        and s.dml_operation_type in ('I','U')
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.d_store_clinical_track
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(clinical_track_id) = cast(s.event_data:ID as string)
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             cast(event_data:DATA_FEED_LAST_UPDATE_DATE as timestamp_ntz(6)) as source_timestamp,
             s.process_timestamp,
             'D_COMPOUND' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_COMPOUND_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'COMPOUND'
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.d_compound
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(compound_id) = cast(s.event_data:ID as string)
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             s.source_timestamp,
             s.process_timestamp,
             'F_COMPOUND_INGREDIENT_TX_LOT' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_COMPOUND_INGREDIENT_TX_LOT_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'COMPOUND_INGREDIENT_TX_LOT'
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.f_compound_ingredient_tx_lot
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(compound_ingredient_tx_lot_id) = cast(s.event_data:ID as string)
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             cast(s.event_data:DATA_FEED_LAST_UPDATE_DATE as timestamp_ntz(6)) as source_timestamp,
             s.process_timestamp,
             'D_COMPOUND_INGREDIENT' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_COMPOUND_INGREDIENT_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'COMPOUND_INGREDIENTS'
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.d_compound_ingredient
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(compound_ingredient_id) = cast(s.event_data:ID as string)
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             cast(s.event_data:DATA_FEED_LAST_UPDATE_DATE as timestamp_ntz(6)) as source_timestamp,
             s.process_timestamp,
             'F_COMPOUND_INGREDIENT_TX' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_COMPOUND_INGREDIENT_TX_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'COMPOUND_INGREDIENTS_TX'
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.f_compound_ingredient_tx
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(compound_ingredient_tx_id) = cast(s.event_data:ID as string)
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             cast(s.event_data:DATA_FEED_LAST_UPDATE_DATE as timestamp_ntz(6)) as source_timestamp,
             s.process_timestamp,
             'D_COMPOUND_INGREDIENT_MODIFIER' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_COMPOUND_INGREDIENT_MODIFIER_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'COMPOUND_INGREDIENTS_MODIFIERS'
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.d_compound_ingredient_modifier
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(compound_ingredient_modifier_id) = cast(s.event_data:ID as string)
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             cast(s.event_data:SOURCE_TIMESTAMP as timestamp_ntz(6)) as source_timestamp,
             s.process_timestamp,
             'D_CREDIT_CARD' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_CREDIT_CARD_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'CREDIT_CARD'
        and s.dml_operation_type in ('I','U')
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.d_credit_card
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(credit_card_id) = cast(s.event_data:ID as string)
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             cast(s.event_data:DATA_FEED_LAST_UPDATE_DATE as timestamp_ntz(6)) as source_timestamp,
             s.process_timestamp,
             'F_STORE_CYCLE_COUNT' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_STORE_CYCLE_COUNT_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'CYCLE_COUNT'
        and s.dml_operation_type in ('I','U')
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.f_store_cycle_count
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(store_cycle_count_id) = cast(s.event_data:ID as string)
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             cast(s.event_data:SOURCE_TIMESTAMP as timestamp_ntz(6)) as source_timestamp,
             s.process_timestamp,
             'D_STORE_DISEASE_CODE' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_STORE_DISEASE_CODE_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'DISEASE_CODES'
        and s.dml_operation_type in ('I','U')
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.d_store_disease_code
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(disease_code_id) = cast(s.event_data:ID as string)
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             cast(s.event_data:DATA_FEED_LAST_UPDATE_DATE as timestamp_ntz(6)) as source_timestamp,
             s.process_timestamp,
             'D_STORE_DRUG' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_STORE_DRUG_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'DRUG'
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.d_store_drug
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(drug_id) = cast(s.event_data:ID as string)
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             cast(s.event_data:DATA_FEED_LAST_UPDATE_DATE as timestamp_ntz(6)) as source_timestamp,
             s.process_timestamp,
             'D_STORE_DRUG_COST_TYPE' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_STORE_DRUG_COST_TYPE_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'DRUG_COST_TYPE'
        and s.dml_operation_type in ('I','U')
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.d_store_drug_cost_type
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(drug_cost_type_id) = cast(s.event_data:ID as string)
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             cast(s.event_data:DATA_FEED_LAST_UPDATE_DATE as timestamp_ntz(6)) as source_timestamp,
             s.process_timestamp,
             'D_STORE_DRUG_COST' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_STORE_DRUG_COST_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'DRUG_COSTS'
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.d_store_drug_cost
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(drug_cost_id) = cast(s.event_data:ID as string)
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             cast(s.event_data:DATA_FEED_LAST_UPDATE_DATE as timestamp_ntz(6)) as source_timestamp,
             s.process_timestamp,
             'F_DRUG_LOCAL_SETTING' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_DRUG_LOCAL_STORE_SETTING_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'DRUG_LOCAL_STORE_SETTINGS'
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.f_drug_local_setting
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(drug_id) = cast(s.event_data:DRUG_ID as string)
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:DRUG_ID as string) as id,
             cast(s.event_data:DATA_FEED_LAST_UPDATE_DATE as timestamp_ntz(6)) as source_timestamp,
             s.process_timestamp,
             'F_DRUG_ORDER' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_DRUG_ORDER_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'DRUG_ORDERS'
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.f_drug_order
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(drug_order_id) = cast(s.event_data:ID as string)
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             s.source_timestamp,
             s.process_timestamp,
             'D_FILE_DATE' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_FILE_DATE_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'FILE_DATES'
        and s.dml_operation_type in ('I','U')
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.d_file_date
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(file_date_id) = cast(s.event_data:ID as string)
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             cast(s.event_data:DATA_FEED_LAST_UPDATE_DATE as timestamp_ntz(6)) as source_timestamp,
             s.process_timestamp,
             'D_GROUP' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_GROUP_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'GROUPS'
        and s.dml_operation_type in ('I','U')
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.d_group
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(group_id) = cast(s.event_data:ID as string)
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             s.source_timestamp,
             s.process_timestamp,
             'D_STORE_ICD10' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_STORE_ICD10_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'ICD10'
        and s.dml_operation_type in ('I','U')
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.d_store_icd10
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(store_icd10_id) = cast(s.event_data:ID as string)
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             cast(s.event_data:DATA_FEED_LAST_UPDATE_DATE as timestamp_ntz(6)) as source_timestamp,
             s.process_timestamp,
             'D_STORE_ICD9' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_STORE_ICD9_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'ICD9'
        and s.dml_operation_type in ('I','U')
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.d_store_icd9
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(store_icd9_id) = cast(s.event_data:ID as string)
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             s.source_timestamp,
             s.process_timestamp,
             'D_STORE_ICD9_DISEASE_CODE_LINK' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_STORE_ICD9_DISEASE_CODE_LINK_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'ICD9_DISEASE_CODE_LINK'
        and s.dml_operation_type in ('I','U')
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.d_store_icd9_disease_code_link
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(store_icd9_disease_code_link_id) = cast(s.event_data:ID as string)
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             cast(s.event_data:DATA_FEED_LAST_UPDATE_DATE as timestamp_ntz(6)) as source_timestamp,
             s.process_timestamp,
             'D_USER_LICENSE_TYPE' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_USER_LICENSE_TYPE_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'LICENSE_TYPE'
        and s.dml_operation_type in ('I','U')
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.d_user_license_type
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(user_license_type_id) = cast(s.event_data:ID as string)
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             cast(s.event_data:DATA_FEED_LAST_UPDATE_DATE as timestamp_ntz(6)) as source_timestamp,
             s.process_timestamp,
             'D_USER_LICENSE' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_USER_LICENSE_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'LICENSES'
        and s.dml_operation_type in ('I','U')
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.d_user_license
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(user_license_id) = cast(s.event_data:ID as string)
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             cast(s.event_data:DATA_FEED_LAST_UPDATE_DATE as timestamp_ntz(6)) as source_timestamp,
             s.process_timestamp,
             'F_LINE_ITEM' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_LINE_ITEM_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'LINE_ITEM'
        and s.dml_operation_type in ('I','U')
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.f_line_item
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(line_item_id) = cast(s.event_data:ID as string)
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             cast(s.event_data:DATA_FEED_LAST_UPDATE_DATE as timestamp_ntz(6)) as source_timestamp,
             s.process_timestamp,
             'F_ORDER_ENTRY' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_ORDER_ENTRY_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'ORDER_ENTRY'
        and s.dml_operation_type in ('I','U')
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.f_order_entry
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(order_entry_id) = cast(s.event_data:ID as string)
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             cast(s.event_data:SOURCE_TIMESTAMP as timestamp_ntz(6)) as source_timestamp,
             s.process_timestamp,
             'D_STORE_PACKAGE_INFORMATION' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_STORE_PACKAGE_INFORMATION_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'PACKAGE_INFO'
        and s.dml_operation_type in ('I','U')
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.d_store_package_information
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(store_package_information_id) = cast(s.event_data:ID as string)
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             cast(s.event_data:DATA_FEED_LAST_UPDATE_DATE as timestamp_ntz(6)) as source_timestamp,
             s.process_timestamp,
             'D_STORE_PATIENT' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_STORE_PATIENT_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'PATIENT'
        and s.dml_operation_type in ('I','U')
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.d_store_patient
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(patient_id) = cast(s.event_data:ID as string)
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ADDRESS_ID as string) as id,
             cast(s.event_data:DATA_FEED_LAST_UPDATE_DATE as timestamp_ntz(6)) as source_timestamp,
             s.process_timestamp,
             'D_PATIENT_ADDRESS_EXTENSION' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_PATIENT_ADDRESS_EXTENSION_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'PATIENT_ADDRESS_EXT'
        and s.dml_operation_type in ('I','U')
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.d_patient_address_extension
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(address_id) = cast(s.event_data:ADDRESS_ID as string)
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             cast(s.event_data:DATA_FEED_LAST_UPDATE_DATE as timestamp_ntz(6)) as source_timestamp,
             s.process_timestamp,
             'D_PATIENT_ADDRESS_LINK' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_PATIENT_ADDRESS_LINK_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'PATIENT_ADDRESS_LINK'
        and s.dml_operation_type in ('I','U')
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.d_patient_address_link
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(patient_address_link_id) = cast(s.event_data:ID as string)
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             cast(s.event_data:LAST_UPDATE_DATE as timestamp_ntz(6)) as source_timestamp,
             s.process_timestamp,
             'D_STORE_PATIENT_DIAGNOSIS' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_STORE_PATIENT_DIAGNOSIS_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'PATIENT_DIAGNOSIS'
        and s.dml_operation_type in ('I','U')
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.d_store_patient_diagnosis
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(store_patient_diagnosis_id) = cast(s.event_data:ID as string)
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             cast(s.event_data:DATA_FEED_LAST_UPDATE_DATE as timestamp_ntz(6)) as source_timestamp,
             s.process_timestamp,
             'D_STORE_PATIENT_DISEASE' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_STORE_PATIENT_DISEASE_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'PATIENT_DISEASE'
        and s.dml_operation_type in ('I','U')
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.d_store_patient_disease
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(store_patient_disease_id) = cast(s.event_data:ID as string)
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             cast(s.event_data:DATA_FEED_LAST_UPDATE_DATE as timestamp_ntz(6)) as source_timestamp,
             s.process_timestamp,
             'D_STORE_PATIENT_EMAIL' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_STORE_PATIENT_EMAIL_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'PATIENT_EMAIL'
        and s.dml_operation_type in ('I','U')
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.d_store_patient_email
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(store_patient_email_id) = cast(s.event_data:ID as string)
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             cast(s.event_data:DATA_FEED_LAST_UPDATE_DATE as timestamp_ntz(6)) as source_timestamp,
             s.process_timestamp,
             'D_STORE_TP_LINK' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_STORE_TP_LINK_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'PATIENT_TP_LINK'
        and s.dml_operation_type in ('I','U')
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.d_store_tp_link
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(tp_link_id) = cast(s.event_data:ID as string)
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             cast(s.event_data:DATA_FEED_LAST_UPDATE_DATE as timestamp_ntz(6)) as source_timestamp,
             s.process_timestamp,
             'F_PAYMENT' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_PAYMENT_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'PAYMENT'
        and s.dml_operation_type in ('I','U')
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.f_payment
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(payment_id) = cast(s.event_data:ID as string)
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             cast(s.event_data:DATA_FEED_LAST_UPDATE_DATE as timestamp_ntz(6)) as source_timestamp,
             s.process_timestamp,
             'F_PAYMENT_ADJUSTMENT' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_PAYMENT_ADJUSTMENT_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'PAYMENT_ADJUSTMENT'
        and s.dml_operation_type in ('I','U')
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.f_payment_adjustment
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(payment_adjustment_id) = cast(s.event_data:ID as string)
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             cast(s.event_data:DATA_FEED_LAST_UPDATE_DATE as timestamp_ntz(6)) as source_timestamp,
             s.process_timestamp,
             'F_PAYMENT_GROUP' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_PAYMENT_GROUP_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'PAYMENT_GROUP'
        and s.dml_operation_type in ('I','U')
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.f_payment_group
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(payment_group_id) = cast(s.event_data:ID as string)
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:PAYMENT_GROUP_ID as string) as id,
             cast(s.event_data:DATA_FEED_LAST_UPDATE_DATE as timestamp_ntz(6)) as source_timestamp,
             s.process_timestamp,
             'F_PAYMENT_GROUP_LINE_ITEM_LINK' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_PAYMENT_GROUP_LINE_ITEM_LINK_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'PAYMENT_GRP_LINE_ITEM_LINK'
        and s.dml_operation_type in ('I','U')
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.f_payment_group_line_item_link
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(payment_group_id) = cast(s.event_data:PAYMENT_GROUP_ID as string)
                          and to_char(line_item_id) = cast(s.event_data:LINE_ITEM_ID as string)
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             cast(s.event_data:DATA_FEED_LAST_UPDATE_DATE as timestamp_ntz(6)) as source_timestamp,
             s.process_timestamp,
             'D_PAYMENT_TYPE' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_PAYMENT_TYPE_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'PAYMENT_TYPE'
        and s.dml_operation_type in ('I','U')
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.d_payment_type
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(payment_type_id) = cast(s.event_data:ID as string)
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             cast(s.event_data:DATA_FEED_LAST_UPDATE_DATE as timestamp_ntz(6)) as source_timestamp,
             s.process_timestamp,
             'D_PHARMACY' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_PHARMACY_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'PHARMACY'
        and s.dml_operation_type in ('I','U')
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.d_pharmacy
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(pharmacy_id) = cast(s.event_data:ID as string)
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             cast(s.event_data:DATA_FEED_LAST_UPDATE_DATE as timestamp_ntz(6)) as source_timestamp,
             s.process_timestamp,
             'D_PHONE' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_PHONE_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'PHONE'
        and s.dml_operation_type in ('I','U')
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.d_phone
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(phone_id) = cast(s.event_data:ID as string)
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             s.source_timestamp,
             s.process_timestamp,
             'D_PICKUP_TYPE' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_PICKUP_TYPE_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'PICKUP_TYPE'
        and s.dml_operation_type in ('I','U')
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.d_pickup_type
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(pickup_type_id) = cast(s.event_data:ID as string)
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             cast(s.event_data:DATA_FEED_LAST_UPDATE_DATE as timestamp_ntz(6)) as source_timestamp,
             s.process_timestamp,
             'D_STORE_PLAN' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_STORE_PLAN_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'PLAN'
        and s.dml_operation_type in ('I','U')
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.d_store_plan
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(plan_id) = cast(s.event_data:ID as string)
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             cast(s.event_data:DATA_FEED_LAST_UPDATE_DATE as timestamp_ntz(6)) as source_timestamp,
             s.process_timestamp,
             'D_STORE_PLAN_TRANSMIT' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_STORE_PLAN_TRANSMIT_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'PLAN_TRANSMIT'
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.d_store_plan_transmit
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(plan_transmit_id) = cast(s.event_data:ID as string)
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             cast(s.event_data:DATA_FEED_LAST_UPDATE_DATE as timestamp_ntz(6)) as source_timestamp,
             s.process_timestamp,
             'D_STORE_PRESCRIBER' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_STORE_PRESCRIBER_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'PRESCRIBER'
        and s.dml_operation_type in ('I','U')
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.d_store_prescriber
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(store_prescriber_id) = cast(s.event_data:ID as string)
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             cast(s.event_data:DATA_FEED_LAST_UPDATE_DATE as timestamp_ntz(6)) as source_timestamp,
             s.process_timestamp,
             'D_STORE_PRESCRIBER_CLINIC_LINK' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_STORE_PRESCRIBER_CLINIC_LINK_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'PRESCRIBER_CLINIC_LINK'
        and s.dml_operation_type in ('I','U')
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.d_store_prescriber_clinic_link
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(store_prescriber_clinic_link_id) = cast(s.event_data:ID as string)
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             cast(s.event_data:DATA_FEED_LAST_UPDATE_DATE as timestamp_ntz(6)) as source_timestamp,
             s.process_timestamp,
             'D_STORE_PRESCRIBER_DEGREE_TYPE' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_STORE_PRESCRIBER_DEGREE_TYPE_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'PRESCRIBER_DEGREE_TYPE'
        and s.dml_operation_type in ('I','U')
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.d_store_prescriber_degree_type
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(store_prescriber_degree_type_id) = cast(s.event_data:ID as string)
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             cast(s.event_data:DATA_FEED_LAST_UPDATE_DATE as timestamp_ntz(6)) as source_timestamp,
             s.process_timestamp,
             'F_PRESCRIBER_EDI' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_PRESCRIBER_EDI_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'PRESCRIBER_EDI'
        and s.dml_operation_type in ('I','U')
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.f_prescriber_edi
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(prescriber_edi_id) = cast(s.event_data:ID as string)
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             cast(s.event_data:SOURCE_TIMESTAMP as timestamp_ntz(6)) as source_timestamp,
             s.process_timestamp,
             'D_STORE_PRESCRIBER_SPECIALTY_CODE' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_STORE_PRESCRIBER_SPECIALTY_CODE_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'PRESCRIBER_SPECIALTY_CODES'
        and s.dml_operation_type in ('I','U')
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.d_store_prescriber_specialty_code
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(store_prescriber_specialty_code_id) = cast(s.event_data:ID as string)
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             cast(s.event_data:DATA_FEED_LAST_UPDATE_DATE as timestamp_ntz(6)) as source_timestamp,
             s.process_timestamp,
             'D_STORE_PRESCRIBER_STATE' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_STORE_PRESCRIBER_STATE_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'PRESCRIBER_STATE'
        and s.dml_operation_type in ('I','U')
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.d_store_prescriber_state
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(store_prescriber_state_id) = cast(s.event_data:ID as string)
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             cast(s.event_data:DATA_FEED_LAST_UPDATE_DATE as timestamp_ntz(6)) as source_timestamp,
             s.process_timestamp,
             'D_STORE_PRICE_CODE' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_STORE_PRICE_CODE_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'PRICE_CODE'
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.d_store_price_code
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(price_code_id) = cast(s.event_data:ID as string)
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             cast(s.event_data:DATA_FEED_LAST_UPDATE_DATE as timestamp_ntz(6)) as source_timestamp,
             s.process_timestamp,
             'F_PURCHASE_ORDER' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_PURCHASE_ORDER_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'PURCHASE_ORDER'
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.f_purchase_order
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(purchase_order_id) = cast(s.event_data:ID as string)
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             cast(s.event_data:DATA_FEED_LAST_UPDATE_DATE as timestamp_ntz(6)) as source_timestamp,
             s.process_timestamp,
             'F_REJECT_REASON' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_REJECT_REASON_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'REJECT_REASON'
        and s.dml_operation_type in ('I','U')
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.f_reject_reason
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(reject_reason_id) = cast(s.event_data:ID as string)
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             cast(s.event_data:DATA_FEED_LAST_UPDATE_DATE as timestamp_ntz(6)) as source_timestamp,
             s.process_timestamp,
             'F_REJECT_REASON_CAUSE' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_REJECT_REASON_CAUSE_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'REJECT_REASON_CAUSE'
        and s.dml_operation_type in ('I','U')
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.f_reject_reason_cause
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(reject_reason_cause_id) = cast(s.event_data:ID as string)
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             cast(s.event_data:DATA_FEED_LAST_UPDATE_DATE as timestamp_ntz(6)) as source_timestamp,
             s.process_timestamp,
             'D_DRUG_REORDER' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_DRUG_REORDER_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'REORDER'
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.d_drug_reorder
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(drug_reorder_id) = cast(s.event_data:ID as string)
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             s.source_timestamp,
             s.process_timestamp,
             'F_RETURN_AND_ADJUSTMENT' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_RETURN_AND_ADJUSTMENT_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'RETURN_AND_ADJUSTMENT'
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.f_return_and_adjustment
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(return_and_adjustment_id) = cast(s.event_data:ID as string)
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             cast(s.event_data:DATA_FEED_LAST_UPDATE_DATE as timestamp_ntz(6)) as source_timestamp,
             s.process_timestamp,
             'F_RX_STATUS_CHANGE' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_RX_STATUS_CHANGE_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'RX_STATUS_CHANGE'
        and s.dml_operation_type in ('I','U')
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.f_rx_status_change
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(rx_status_change_id) = cast(s.event_data:ID as string)
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             cast(s.event_data:DATA_FEED_LAST_UPDATE_DATE as timestamp_ntz(6)) as source_timestamp,
             s.process_timestamp,
             'F_RX' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_RX_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'RX_SUMMARY'
        and s.dml_operation_type in ('I','U')
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and cast(s.event_data:RX_SOURCE as number) != 21
        and not exists (select null
                          from edw.f_rx
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(rx_id) = cast(s.event_data:ID as string)
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             cast(s.event_data:DATA_FEED_LAST_UPDATE_DATE as timestamp_ntz(6)) as source_timestamp,
             s.process_timestamp,
             'F_RX_TX_LINK' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_RX_TX_LINK_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'RX_TX'
        and s.dml_operation_type in ('I','U')
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and cast(s.event_data:NHIN_STORE_ID as number) = s.nhin_store_id
        and not exists (select null
                          from edw.f_rx_tx_link
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(rx_tx_id) = cast(s.event_data:ID as string)
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             s.source_timestamp,
             s.process_timestamp,
             'F_RX_TX_BARCODE_SCAN_HISTORY' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_RX_TX_BARCODE_SCAN_HISTORY_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'RX_TX_BARCODE_SCAN_HISTORY'
        and s.dml_operation_type in ('I','U')
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.f_rx_tx_barcode_scan_history
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(rx_tx_barcode_scan_history_id) = cast(s.event_data:ID as string)
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             cast(s.event_data:DATA_FEED_LAST_UPDATE_DATE as timestamp_ntz(6)) as source_timestamp,
             s.process_timestamp,
             'F_STORE_RX_TX_DIAGNOSIS_CODE' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_STORE_RX_TX_DIAGNOSIS_CODE_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'RX_TX_DIAGNOSIS_CODES'
        and s.dml_operation_type in ('I','U')
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.f_store_rx_tx_diagnosis_code
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(store_rx_tx_diagnosis_code_id) = cast(s.event_data:ID as string)
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             cast(s.event_data:DATA_FEED_LAST_UPDATE_DATE as timestamp_ntz(6)) as source_timestamp,
             s.process_timestamp,
             'F_RX_TX_PAYMENT' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_RX_TX_PAYMENT_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'RX_TX_PAYMENT'
        and s.dml_operation_type in ('I','U')
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.f_rx_tx_payment
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(rx_tx_payment_id) = cast(s.event_data:ID as string)
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             cast(s.event_data:DATA_FEED_LAST_UPDATE_DATE as timestamp_ntz(6)) as source_timestamp,
             s.process_timestamp,
             'F_SHIPMENT' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_SHIPMENT_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'SHIPMENT'
        and s.dml_operation_type in ('I','U')
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.f_shipment
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(shipment_id) = cast(s.event_data:ID as string)
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             cast(s.event_data:DATA_FEED_LAST_UPDATE_DATE as timestamp_ntz(6)) as source_timestamp,
             s.process_timestamp,
             'D_STORE_LICENSE' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_STORE_LICENSE_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'STORE_LICENSE'
        and s.dml_operation_type in ('I','U')
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.d_store_license
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(store_license_identifier) = cast(s.event_data:ID as string)
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             cast(s.event_data:DATA_FEED_LAST_UPDATE_DATE as timestamp_ntz(6)) as source_timestamp,
             s.process_timestamp,
             'D_STORE_SETTING' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_STORE_SETTING_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'STORE_SETTINGS'
        and s.dml_operation_type in ('I','U')
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.d_store_setting
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(store_setting_id) = cast(s.event_data:ID as string)
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             cast(s.event_data:DATA_FEED_LAST_UPDATE_DATE as timestamp_ntz(6)) as source_timestamp,
             s.process_timestamp,
             'F_TASK_HISTORY' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_TASK_HISTORY_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'TASK_HISTORY'
        and s.dml_operation_type in ('I','U')
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.f_task_history
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(task_history_id) = cast(s.event_data:ID as string)
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             cast(s.event_data:SOURCE_TIMESTAMP as timestamp_ntz(6)) as source_timestamp,
             s.process_timestamp,
             'F_TX_TP_DUR' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_TX_TP_DUR_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'TP_DUR'
        and s.dml_operation_type in ('I','U')
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.f_tx_tp_dur
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(tx_tp_dur_id) = cast(s.event_data:ID as string)
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             cast(s.event_data:SOURCE_TIMESTAMP as timestamp_ntz(6)) as source_timestamp,
             s.process_timestamp,
             'F_TX_TP_OTHER_PAYER_AMOUNT' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_TX_TP_OTHER_PAYER_AMOUNT_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'TP_OTHER_PAYER_AMOUNTS'
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.f_tx_tp_other_payer_amount
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(tx_tp_other_payer_amount_id) = cast(s.event_data:ID as string)
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             cast(s.event_data:SOURCE_TIMESTAMP as timestamp_ntz(6)) as source_timestamp,
             s.process_timestamp,
             'F_TX_TP_OTHER_PAYER_REJECT' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_TX_TP_OTHER_PAYER_REJECT_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'TP_OTHER_PAYER_REJECTS'
        and s.dml_operation_type in ('I','U')
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.f_tx_tp_other_payer_reject
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(tx_tp_other_payer_reject_id) = cast(s.event_data:ID as string)
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             cast(s.event_data:SOURCE_TIMESTAMP as timestamp_ntz(6)) as source_timestamp,
             s.process_timestamp,
             'F_TX_TP_OTHER_PAYER' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_TX_TP_OTHER_PAYER_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'TP_OTHER_PAYERS'
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.f_tx_tp_other_payer
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(tx_tp_other_payer_id) = cast(s.event_data:ID as string)
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             cast(s.event_data:SOURCE_TIMESTAMP as timestamp_ntz(6)) as source_timestamp,
             s.process_timestamp,
             'F_TX_TP_RESPONSE_ADDITIONAL_MESSAGE' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_TX_TP_RESPONSE_ADDITIONAL_MESSAGE_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'TP_RESP_ADDITIONAL_MESSAGE'
        and s.dml_operation_type in ('I','U')
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.f_tx_tp_response_additional_message
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(tx_tp_response_additional_message_id) = cast(s.event_data:ID as string)
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             s.source_timestamp,
             s.process_timestamp,
             'F_TX_TP_RESPONSE_DETAIL_AMOUNT' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_TX_TP_RESPONSE_DETAIL_AMOUNT_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'TP_RESP_AMOUNT'
        and s.dml_operation_type in ('I','U')
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.f_tx_tp_response_detail_amount
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(tx_tp_response_detail_amount_id) = cast(s.event_data:ID as string)
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             cast(s.event_data:SOURCE_TIMESTAMP as timestamp_ntz(6)) as source_timestamp,
             s.process_timestamp,
             'F_TX_TP_RESPONSE_APPROVAL_MESSAGE' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_TX_TP_RESPONSE_APPROVAL_MESSAGE_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'TP_RESP_APPROVAL_MESSAGE'
        and s.dml_operation_type in ('I','U')
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.f_tx_tp_response_approval_message
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(tx_tp_response_approval_message_id) = cast(s.event_data:ID as string)
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             cast(s.event_data:SOURCE_TIMESTAMP as timestamp_ntz(6)) as source_timestamp,
             s.process_timestamp,
             'F_TX_TP_RESPONSE_PREFERRED_PRODUCT' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_TX_TP_RESPONSE_PREFERRED_PRODUCT_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'TP_RESP_PREFERRED_PRODUCT'
        and s.dml_operation_type in ('I','U')
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.f_tx_tp_response_preferred_product
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(tx_tp_response_preferred_product_id) = cast(s.event_data:ID as string)
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             s.source_timestamp,
             s.process_timestamp,
             'F_TX_TP_RESPONSE_DETAIL' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_TX_TP_RESPONSE_DETAIL_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'TP_RESPONSE_CLAIM_DETAIL'
        and s.dml_operation_type in ('I','U')
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.f_tx_tp_response_detail
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(tx_tp_response_detail_id) = cast(s.event_data:ID as string)
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             s.source_timestamp,
             s.process_timestamp,
             'F_TX_TP_SUBMIT_DETAIL' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_TX_TP_SUBMIT_DETAIL_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'TP_SUBMIT_CLAIM_DETAIL'
        and s.dml_operation_type in ('I','U')
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.f_tx_tp_submit_detail
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(tx_tp_submit_detail_id) = cast(s.event_data:ID as string)
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             cast(s.event_data:SOURCE_TIMESTAMP as timestamp_ntz(6)) as source_timestamp,
             s.process_timestamp,
             'F_TX_TP_SUBMIT_DETAIL_SEGMENT_CODE' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_TX_TP_SUBMIT_DETAIL_SEGMENT_CODE_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'TP_SUBMIT_CLAIM_SEG_CODE'
        and s.dml_operation_type in ('I','U')
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.f_tx_tp_submit_detail_segment_code
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(tx_tp_submit_detail_segment_code_id) = cast(s.event_data:ID as string)
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             cast(s.event_data:DATA_FEED_LAST_UPDATE_DATE as timestamp_ntz(6)) as source_timestamp,
             s.process_timestamp,
             'F_TX_TP_TRANSMIT_QUEUE' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_TX_TP_TRANSMIT_QUEUE_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'TP_TRANSMIT_QUEUE'
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.f_tx_tp_transmit_queue
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(tx_tp_transmit_queue_id) = cast(s.event_data:ID as string)
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             cast(s.event_data:DATA_FEED_LAST_UPDATE_DATE as timestamp_ntz(6)) as source_timestamp,
             s.process_timestamp,
             'F_TX_TP_TRANSMIT_REJECT' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_TX_TP_TRANSMIT_REJECT_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'TP_TRANSMIT_REJECTS'
        and s.dml_operation_type in ('I','U')
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.f_tx_tp_transmit_reject
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(tx_tp_transmit_reject_id) = cast(s.event_data:ID as string)
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             cast(s.event_data:DATA_FEED_LAST_UPDATE_DATE as timestamp_ntz(6)) as source_timestamp,
             s.process_timestamp,
             'F_TRANSFER' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_TRANSFER_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'TRANSFER'
        and s.dml_operation_type in ('I','U')
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.f_transfer
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(transfer_id) = cast(s.event_data:ID as string)
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             cast(s.event_data:DATA_FEED_LAST_UPDATE_DATE as timestamp_ntz(6)) as source_timestamp,
             s.process_timestamp,
             'F_TRANSFER_PRIOR_FILL_DATES' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_TRANSFER_PRIOR_FILL_DATES_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'TRANSFER_FILL_DATES'
        and s.dml_operation_type in ('I','U')
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.f_transfer_prior_fill_dates
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(transfer_prior_fill_id) = cast(s.event_data:ID as string)
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             cast(s.event_data:DATA_FEED_LAST_UPDATE_DATE as timestamp_ntz(6)) as source_timestamp,
             s.process_timestamp,
             'D_STORE_TRANSFER_REASON' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_STORE_TRANSFER_REASON_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'TRANSFER_REASON'
        and s.dml_operation_type in ('I','U')
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.d_store_transfer_reason
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(store_transfer_reason_id) = cast(s.event_data:ID as string)
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             cast(s.event_data:DATA_FEED_LAST_UPDATE_DATE as timestamp_ntz(6)) as source_timestamp,
             s.process_timestamp,
             'F_TRANSFER_REQUEST_QUEUE' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_TRANSFER_REQUEST_QUEUE_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'TRANSFER_REQUEST_QUEUE'
        and s.dml_operation_type in ('I','U')
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.f_transfer_request_queue
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(transfer_request_queue_id) = cast(s.event_data:ID as string)
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             cast(s.event_data:DATA_FEED_LAST_UPDATE_DATE as timestamp_ntz(6)) as source_timestamp,
             s.process_timestamp,
             'F_TX_TP_LINK' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_TX_TP_LINK_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'TX_TP'
        and s.dml_operation_type in ('I','U')
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.f_tx_tp_link
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(tx_tp_id) = cast(s.event_data:ID as string)
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             cast(s.event_data:SOURCE_TIMESTAMP as timestamp_ntz(6)) as source_timestamp,
             s.process_timestamp,
             'F_TX_TP_DENIAL_CLARIFICATION' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_TX_TP_DENIAL_CLARIFICATION_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'TX_TP_DENIAL_CLARIFICATION'
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.f_tx_tp_denial_clarification
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(tx_tp_denial_clarification_id) = cast(s.event_data:ID as string)
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:GROUP_ID as string) as id,
             cast(s.event_data:DATA_FEED_LAST_UPDATE_DATE as timestamp_ntz(6)) as source_timestamp,
             s.process_timestamp,
             'D_USER_GROUP' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_USER_GROUP_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'USER_GROUPS_LINK'
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.d_user_group
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(user_identifier) = cast(s.event_data:USER_ID as string)
                          and to_char(group_id) = cast(s.event_data:GROUP_ID as string)
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             cast(s.event_data:DATA_FEED_LAST_UPDATE_DATE as timestamp_ntz(6)) as source_timestamp,
             s.process_timestamp,
             'D_USER' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_USER_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'USERS'
        and s.dml_operation_type in ('I','U')
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.d_user
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(user_identifier) = cast(s.event_data:ID as string)
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             cast(s.event_data:DATA_FEED_LAST_UPDATE_DATE as timestamp_ntz(6)) as source_timestamp,
             s.process_timestamp,
             'D_STORE_VENDOR' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_STORE_VENDOR_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'VENDOR'
        and s.dml_operation_type in ('I','U')
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.d_store_vendor
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(vendor_id) = cast(s.event_data:ID as string)
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             cast(s.event_data:DATA_FEED_LAST_UPDATE_DATE as timestamp_ntz(6)) as source_timestamp,
             s.process_timestamp,
             'F_WORKFLOW_HISTORY' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_WORKFLOW_HISTORY_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'WORKFLOW_HISTORY'
        and s.dml_operation_type in ('I','U')
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.f_workflow_history
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(workflow_history_id) = cast(s.event_data:ID as string)
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             cast(s.event_data:DATA_FEED_LAST_UPDATE_DATE as timestamp_ntz(6)) as source_timestamp,
             s.process_timestamp,
             'D_WORKFLOW_STATE' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_WORKFLOW_STATE_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'WORKFLOW_STATE'
        and s.dml_operation_type in ('I','U')
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.d_workflow_state
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(workflow_state_id) = cast(s.event_data:ID as string)
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             s.source_timestamp,
             s.process_timestamp,
             'D_WORKFLOW_STATE_ATTRIBUTE' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_WORKFLOW_STATE_ATTRIBUTE_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'WORKFLOW_STATE_ATTRIBUTE'
        and s.dml_operation_type in ('I','U')
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.d_workflow_state_attribute
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(workflow_state_attribute_id) = cast(s.event_data:ID as string)
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             cast(s.event_data:DATA_FEED_LAST_UPDATE_DATE as timestamp_ntz(6)) as source_timestamp,
             s.process_timestamp,
             'F_WORKFLOW_TOKEN' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_WORKFLOW_TOKEN_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'WORKFLOW_TOKEN'
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.f_workflow_token
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(workflow_token_id) = cast(s.event_data:ID as string)
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             s.source_timestamp,
             s.process_timestamp,
             'D_WORKFLOW_TRANSITION' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_WORKFLOW_TRANSITION_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'WORKFLOW_TRANSITION'
        and s.dml_operation_type in ('I','U')
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.d_workflow_transition
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(workflow_transition_id) = cast(s.event_data:ID as string)
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             s.source_timestamp,
             s.process_timestamp,
             'D_WORKFLOW_TYPE' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_WORKFLOW_TYPE_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'WORKFLOW_TYPE'
        and s.dml_operation_type in ('I','U')
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.d_workflow_type
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(workflow_type_id) = cast(s.event_data:ID as string)
                          and source_system_id = 4)
      --ERXDWPS-5376 New tables added
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             s.source_timestamp,
             s.process_timestamp,
             'D_STORE_CENTRAL_FILL_DELIVERY_SCHEDULE' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_STORE_CENTRAL_FILL_DELIVERY_SCHEDULE_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'CF_DELIVERY_SCHEDULE'
        and s.dml_operation_type in ('I','U')
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.d_store_central_fill_delivery_schedule
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(store_central_fill_delivery_schedule_id) = cast(s.event_data:ID as string)
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             source_timestamp,
             s.process_timestamp,
             'D_STORE_CENTRAL_FILL_FACILITY' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_STORE_CENTRAL_FILL_FACILITY_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'CF_FACILITY'
        and s.dml_operation_type in ('I','U')
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.d_store_central_fill_facility
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(store_central_fill_facility_id) = cast(s.event_data:ID as string)
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             cast(s.event_data:DATA_FEED_LAST_UPDATE_DATE as timestamp_ntz(6)) as source_timestamp,
             s.process_timestamp,
             'D_STORE_CENTRAL_FILL_FORMULARY' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_STORE_CENTRAL_FILL_FORMULARY_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'CF_FORMULARY'
        and s.dml_operation_type in ('I','U')
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.d_store_central_fill_formulary
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(store_central_fill_formulary_id) = cast(s.event_data:ID as string)
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             s.source_timestamp,
             s.process_timestamp,
             'D_STORE_PRICE_CODE_VALUE' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_STORE_PRICE_CODE_VALUES_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'PRICE_CODE_VALUES'
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.d_store_price_code_value
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(price_code_value_id) = cast(s.event_data:ID as string)
                          and source_system_id = 4)
      --ERXDWPS-5376 Archive tables validation
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             cast(s.event_data:DATA_FEED_LAST_UPDATE_DATE as timestamp_ntz(6)) as source_timestamp,
             s.process_timestamp,
             'F_RX_ARCHIVE' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_RX_ARCHIVE_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'RX_SUMMARY'
        and s.dml_operation_type in ('I','U')
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and cast(s.event_data:RX_SOURCE as number) != 21
        and not exists (select null
                          from edw.f_rx_archive
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(rx_id) = cast(s.event_data:ID as string)
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             cast(s.event_data:DATA_FEED_LAST_UPDATE_DATE as timestamp_ntz(6)) as source_timestamp,
             s.process_timestamp,
             'F_RX_TX_LINK_ARCHIVE' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_RX_TX_LINK_ARCHIVE_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'RX_TX'
        and s.dml_operation_type in ('I','U')
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and cast(s.event_data:NHIN_STORE_ID as number) = s.nhin_store_id
        and not exists (select null
                          from edw.f_rx_tx_link_archive
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(rx_tx_id) = cast(s.event_data:ID as string)
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             cast(s.event_data:DATA_FEED_LAST_UPDATE_DATE as timestamp_ntz(6)) as source_timestamp,
             s.process_timestamp,
             'F_TASK_HISTORY_ARCHIVE' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_TASK_HISTORY_ARCHIVE_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'TASK_HISTORY'
        and s.dml_operation_type in ('I','U')
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.f_task_history_archive
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(task_history_id) = cast(s.event_data:ID as string)
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             cast(s.event_data:DATA_FEED_LAST_UPDATE_DATE as timestamp_ntz(6)) as source_timestamp,
             s.process_timestamp,
             'F_TX_TP_LINK_ARCHIVE' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_TX_TP_LINK_ARCHIVE_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'TX_TP'
        and s.dml_operation_type in ('I','U')
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.f_tx_tp_link_archive
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(tx_tp_id) = cast(s.event_data:ID as string)
                          and source_system_id = 4)
      --ERXDWPS-5376 EPS History tables validation
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             cast(s.event_data:DATA_FEED_LAST_UPDATE_DATE as timestamp_ntz(6)) as source_timestamp,
             s.process_timestamp,
             'D_ADDRESS_HIST' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_ADDRESS_HIST_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'ADDRESS'
        and s.dml_operation_type in ('I','U') --JOB_EPS_ADDRESS_HIST_EDW jojb do not have this condition. But JOB_EPS_ADDRESS_EDW has.
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null from edw.d_address_hist
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(address_id) = cast(s.event_data:ID as string)
                          and source_timestamp = nvl(cast(s.event_data:DATA_FEED_LAST_UPDATE_DATE as timestamp_ntz(6)), cast('1900-01-01 12:00:00.000' as timestamp_ntz(6)))
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             cast(s.event_data:DATA_FEED_LAST_UPDATE_DATE as timestamp_ntz(6)) as source_timestamp,
             s.process_timestamp,
             'F_DRUG_LOCAL_SETTING_HIST' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_DRUG_LOCAL_SETTING_HIST_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'DRUG_LOCAL_STORE_SETTINGS'
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.f_drug_local_setting_hist
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(drug_id) = cast(s.event_data:DRUG_ID as string)
                          and source_timestamp = nvl(cast(s.event_data:DATA_FEED_LAST_UPDATE_DATE as timestamp_ntz(6)), cast('1900-01-01 12:00:00.000' as timestamp_ntz(6)))
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             cast(s.event_data:DATA_FEED_LAST_UPDATE_DATE as timestamp_ntz(6)) as source_timestamp,
             s.process_timestamp,
             'D_DRUG_REORDER_HIST' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_DRUG_REORDER_HIST_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'REORDER'
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.d_drug_reorder_hist
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(drug_reorder_id) = cast(s.event_data:ID as string)
                          and source_timestamp = nvl(cast(s.event_data:DATA_FEED_LAST_UPDATE_DATE as timestamp_ntz(6)), cast('1900-01-01 12:00:00.000' as timestamp_ntz(6)))
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             s.source_timestamp,
             s.process_timestamp,
             'D_FILE_DATE_HIST' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_FILE_DATE_HIST_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'FILE_DATES'
        and s.dml_operation_type in ('I','U') --JOB_EPS_FILE_DATE_HIST_EDW jojb do not have this condition. But JOB_EPS_FILE_DATE_EDW has.
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.d_file_date_hist
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(file_date_id) = cast(s.event_data:ID as string)
                          and source_timestamp = s.source_timestamp
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ADDRESS_ID as string) as id,
             cast(s.event_data:DATA_FEED_LAST_UPDATE_DATE as timestamp_ntz(6)) as source_timestamp,
             s.process_timestamp,
             'D_PATIENT_ADDRESS_EXTENSION_HIST' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_PATIENT_ADDRESS_EXTENSION_HIST_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'PATIENT_ADDRESS_EXT'
        and s.dml_operation_type in ('I','U')
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.d_patient_address_extension_hist
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(address_id) = cast(s.event_data:ADDRESS_ID as string)
                          and source_timestamp = nvl(cast(s.event_data:DATA_FEED_LAST_UPDATE_DATE as timestamp_ntz(6)), cast('1900-01-01 12:00:00.000' as timestamp_ntz(6)))
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             cast(s.event_data:DATA_FEED_LAST_UPDATE_DATE as timestamp_ntz(6)) as source_timestamp,
             s.process_timestamp,
             'D_PATIENT_ADDRESS_LINK_HIST' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_PATIENT_ADDRESS_LINK_HIST_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'PATIENT_ADDRESS_LINK'
        and s.dml_operation_type in ('I','U')
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.d_patient_address_link_hist
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(patient_address_link_id) = cast(s.event_data:ID as string)
                          and source_timestamp = nvl(cast(s.event_data:DATA_FEED_LAST_UPDATE_DATE as timestamp_ntz(6)), cast('1900-01-01 12:00:00.000' as timestamp_ntz(6)))
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             cast(s.event_data:SOURCE_TIMESTAMP as timestamp_ntz(6)) as source_timestamp,
             s.process_timestamp,
             'F_STORE_CALL_INSURANCE_HIST' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_STORE_CALL_INSURANCE_HIST_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'CALL_INSURANCE'
        and s.dml_operation_type in ('I','U')
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.f_store_call_insurance_hist
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(store_call_insurance_id) = cast(s.event_data:ID as string)
                          and source_timestamp = cast(s.event_data:SOURCE_TIMESTAMP as timestamp_ntz(6))
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             cast(s.event_data:SOURCE_TIMESTAMP as timestamp_ntz(6)) as source_timestamp,
             s.process_timestamp,
             'F_STORE_CALL_PATIENT_HIST' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_STORE_CALL_PATIENT_HIST_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'CALL_PATIENT'
        and s.dml_operation_type in ('I','U')
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.f_store_call_patient_hist
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(store_call_patient_id) = cast(s.event_data:ID as string)
                          and source_timestamp = cast(s.event_data:SOURCE_TIMESTAMP as timestamp_ntz(6))
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             cast(s.event_data:SOURCE_TIMESTAMP as timestamp_ntz(6)) as source_timestamp,
             s.process_timestamp,
             'F_STORE_CALL_PHARMACY_HIST' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_STORE_CALL_PHARMACY_HIST_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'CALL_PHARMACY'
        and s.dml_operation_type in ('I','U')
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.f_store_call_pharmacy_hist
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(store_call_pharmacy_id) = cast(s.event_data:ID as string)
                          and source_timestamp = cast(s.event_data:SOURCE_TIMESTAMP as timestamp_ntz(6))
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             cast(s.event_data:SOURCE_TIMESTAMP as timestamp_ntz(6)) as source_timestamp,
             s.process_timestamp,
             'F_STORE_CALL_PRESCRIBER_HIST' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_STORE_CALL_PRESCRIBER_HIST_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'CALL_PRESCRIBER'
        and s.dml_operation_type in ('I','U')
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.f_store_call_prescriber_hist
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(store_call_prescriber_id) = cast(s.event_data:ID as string)
                          and source_timestamp = cast(s.event_data:SOURCE_TIMESTAMP as timestamp_ntz(6))
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             s.source_timestamp,
             s.process_timestamp,
             'D_STORE_CENTRAL_FILL_DELIVERY_SCHEDULE_HIST' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_STORE_CENTRAL_FILL_DELIVERY_SCHEDULE_HIST_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'CF_DELIVERY_SCHEDULE'
        and s.dml_operation_type in ('I','U')
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.d_store_central_fill_delivery_schedule_hist
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(store_central_fill_delivery_schedule_id) = cast(s.event_data:ID as string)
                          and source_timestamp = s.source_timestamp
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             source_timestamp,
             s.process_timestamp,
             'D_STORE_CENTRAL_FILL_FACILITY_HIST' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_STORE_CENTRAL_FILL_FACILITY_HIST_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'CF_FACILITY'
        and s.dml_operation_type in ('I','U')
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.d_store_central_fill_facility_hist
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(store_central_fill_facility_id) = cast(s.event_data:ID as string)
                          and source_timestamp = s.source_timestamp
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             cast(s.event_data:DATA_FEED_LAST_UPDATE_DATE as timestamp_ntz(6)) as source_timestamp,
             s.process_timestamp,
             'D_STORE_CENTRAL_FILL_FORMULARY_HIST' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_STORE_CENTRAL_FILL_FORMULARY_HIST_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'CF_FORMULARY'
        and s.dml_operation_type in ('I','U')
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.d_store_central_fill_formulary_hist
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(store_central_fill_formulary_id) = cast(s.event_data:ID as string)
                          and source_timestamp = nvl(cast(s.event_data:DATA_FEED_LAST_UPDATE_DATE as timestamp_ntz(6)), cast('1900-01-01 12:00:00.000' as timestamp_ntz(6)))
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             cast(s.event_data:DATA_FEED_LAST_UPDATE_DATE as timestamp_ntz(6)) as source_timestamp,
             s.process_timestamp,
             'F_STORE_CYCLE_COUNT_HIST' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_STORE_CYCLE_COUNT_HIST_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'CYCLE_COUNT'
        and s.dml_operation_type in ('I','U')
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.f_store_cycle_count_hist
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(store_cycle_count_id) = cast(s.event_data:ID as string)
                          and source_timestamp = nvl(cast(s.event_data:DATA_FEED_LAST_UPDATE_DATE as timestamp_ntz(6)), cast('1900-01-01 12:00:00.000' as timestamp_ntz(6)))
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             cast(s.event_data:DATA_FEED_LAST_UPDATE_DATE as timestamp_ntz(6)) as source_timestamp,
             s.process_timestamp,
             'D_STORE_DRUG_COST_HIST' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_STORE_DRUG_COST_HIST_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'DRUG_COSTS'
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.d_store_drug_cost_hist
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(drug_cost_id) = cast(s.event_data:ID as string)
                          and source_timestamp = nvl(cast(s.event_data:DATA_FEED_LAST_UPDATE_DATE as timestamp_ntz(6)), cast('1900-01-01 12:00:00.000' as timestamp_ntz(6)))
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             cast(s.event_data:LAST_UPDATE_DATE as timestamp_ntz(6)) as source_timestamp,
             s.process_timestamp,
             'D_STORE_PATIENT_DIAGNOSIS_HIST' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_STORE_PATIENT_DIAGNOSIS_HIST_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'PATIENT_DIAGNOSIS'
        and s.dml_operation_type in ('I','U')
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.d_store_patient_diagnosis_hist
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(store_patient_diagnosis_id) = cast(s.event_data:ID as string)
                          and source_timestamp = nvl(cast(s.event_data:LAST_UPDATE_DATE as timestamp_ntz(6)), cast('1900-01-01 12:00:00.000' as timestamp_ntz(6)))
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             cast(s.event_data:DATA_FEED_LAST_UPDATE_DATE as timestamp_ntz(6)) as source_timestamp,
             s.process_timestamp,
             'D_STORE_PATIENT_DISEASE_HIST' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_STORE_PATIENT_DISEASE_HIST_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'PATIENT_DISEASE'
        and s.dml_operation_type in ('I','U')
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.d_store_patient_disease_hist
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(store_patient_disease_id) = cast(s.event_data:ID as string)
                          and source_timestamp = nvl(cast(s.event_data:DATA_FEED_LAST_UPDATE_DATE as timestamp_ntz(6)), cast('1900-01-01 12:00:00.000' as timestamp_ntz(6)))
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             cast(s.event_data:DATA_FEED_LAST_UPDATE_DATE as timestamp_ntz(6)) as source_timestamp,
             s.process_timestamp,
             'D_STORE_PATIENT_EMAIL_HIST' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_STORE_PATIENT_EMAIL_HIST_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'PATIENT_EMAIL'
        and s.dml_operation_type in ('I','U')
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.d_store_patient_email_hist
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(store_patient_email_id) = cast(s.event_data:ID as string)
                          and source_timestamp = nvl(cast(s.event_data:DATA_FEED_LAST_UPDATE_DATE as timestamp_ntz(6)), cast('1900-01-01 12:00:00.000' as timestamp_ntz(6)))
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             cast(s.event_data:DATA_FEED_LAST_UPDATE_DATE as timestamp_ntz(6)) as source_timestamp,
             s.process_timestamp,
             'D_STORE_PATIENT_HIST' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_STORE_PATIENT_HIST_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'PATIENT'
        and s.dml_operation_type in ('I','U')
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.d_store_patient_hist
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(patient_id) = cast(s.event_data:ID as string)
                          and source_timestamp = nvl(cast(s.event_data:DATA_FEED_LAST_UPDATE_DATE as timestamp_ntz(6)), cast('1900-01-01 12:00:00.000' as timestamp_ntz(6)))
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             cast(s.event_data:DATA_FEED_LAST_UPDATE_DATE as timestamp_ntz(6)) as source_timestamp,
             s.process_timestamp,
             'D_STORE_PRICE_CODE_HIST' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_STORE_PRICE_CODE_HIST_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'PRICE_CODE'
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.d_store_price_code_hist
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(price_code_id) = cast(s.event_data:ID as string)
                          and source_timestamp = nvl(cast(s.event_data:DATA_FEED_LAST_UPDATE_DATE as timestamp_ntz(6)), cast('1900-01-01 12:00:00.000' as timestamp_ntz(6)))
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             s.source_timestamp,
             s.process_timestamp,
             'D_STORE_PRICE_CODE_VALUE_HIST' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_STORE_PRICE_CODE_VALUES_HIST_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'PRICE_CODE_VALUES'
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.d_store_price_code_value_hist
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(price_code_value_id) = cast(s.event_data:ID as string)
                          and source_timestamp = s.source_timestamp
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             cast(s.event_data:DATA_FEED_LAST_UPDATE_DATE as timestamp_ntz(6)) as source_timestamp,
             s.process_timestamp,
             'D_STORE_SETTING_HIST' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_STORE_SETTING_HIST_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'STORE_SETTINGS'
        and s.dml_operation_type in ('I','U')
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.d_store_setting_hist
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(store_setting_id) = cast(s.event_data:ID as string)
                          and source_timestamp = nvl(cast(s.event_data:DATA_FEED_LAST_UPDATE_DATE as timestamp_ntz(6)), cast('1900-01-01 12:00:00.000' as timestamp_ntz(6)))
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             cast(s.event_data:DATA_FEED_LAST_UPDATE_DATE as timestamp_ntz(6)) as source_timestamp,
             s.process_timestamp,
             'D_USER_HIST' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_USER_HIST_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'USERS'
        and s.dml_operation_type in ('I','U')
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.d_user_hist
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(user_identifier) = cast(s.event_data:ID as string)
                          and source_timestamp = nvl(cast(s.event_data:DATA_FEED_LAST_UPDATE_DATE as timestamp_ntz(6)), cast('1900-01-01 12:00:00.000' as timestamp_ntz(6)))
                          and source_system_id = 4)
      UNION ALL
      select distinct s.chain_id,
             s.nhin_store_id,
             cast(s.event_data:ID as string) as id,
             cast(s.event_data:DATA_FEED_LAST_UPDATE_DATE as timestamp_ntz(6)) as source_timestamp,
             s.process_timestamp,
             'D_USER_LICENSE_HIST' as target_table,
             4 as source_system_id
      from json_stage.symmetric_event_stage s,
           (select chain_id, min(min_process_timestamp) min_process_timestamp, max(max_process_timestamp) max_process_timestamp
              from (
                     select ejc.chain_id, ej.event_id, min(ejc.process_data_begin_date) as min_process_timestamp, max(ejc.process_data_end_date) as max_process_timestamp
                            from etl_manager.event e,
                                 etl_manager.event_job ej,
                                 etl_manager.event_job_chain ejc
                            where e.status = 'S'
                            and e.event_type = 'STAGE TO EDW ETL'
                            and e.event_begin_date >= dateadd(day,-2,current_date()) --look back period
                            and e.event_id = ej.event_id
                            and ej.job_name in ('JOB_EPS_USER_LICENSE_HIST_EDW')
                            and ej.event_id = ejc.event_id
                            and ej.job_name = ejc.job_name
                            and {% condition chain.chain_id %} ejc.chain_id {% endcondition %}
                          group by 1,2
                   )
              group by 1
           ) e
      where s.table_name = 'LICENSES'
        and s.dml_operation_type in ('I','U')
        and {% condition chain.chain_id %} s.chain_id {% endcondition %}
        and {% condition store.nhin_store_id %} s.nhin_store_id {% endcondition %}
        and s.chain_id = e.chain_id
        and s.process_timestamp >= dateadd(day,-2,current_date())
        and s.process_timestamp < e.max_process_timestamp
        and not exists (select null
                          from edw.d_user_license_hist
                          where chain_id = s.chain_id
                          and nhin_store_id = s.nhin_store_id
                          and to_char(user_license_id) = cast(s.event_data:ID as string)
                          and source_timestamp = nvl(cast(s.event_data:DATA_FEED_LAST_UPDATE_DATE as timestamp_ntz(6)), cast('1900-01-01 12:00:00.000' as timestamp_ntz(6)))
                          and source_system_id = 4)
      ) EDW_MISSING_RECORDS
       ;;
  }

  dimension: id {
    label: "Source Table Unique Identifier"
    type: string
    sql: ${TABLE}.ID ;;
  }

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    type: number
    sql: ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${id} ;; #ERXLPS-1649
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

  dimension_group: process {
    label: "Process"
    description: "Date record was unloaded and processed into BI system"
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
    sql: ${TABLE}.PROCESS_TIMESTAMP ;;
  }

  dimension: edw_target_table {
    label: "EDW Target Table"
    description: "EDW Table which has missing records"
    type: string
    sql: ${TABLE}.TARGET_TABLE ;;
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
      store_alignment.division,
      store_alignment.region,
      store_alignment.district,

      #Changes made w.r.t ERXLPS-126
      store.store_number,
      store.store_name,
      dq_edw_missing_records_by_source_system.edw_target_table,
      dq_edw_missing_records_by_source_system.id,
      dq_edw_missing_records_by_source_system.source_timestamp
    ]
  }
}

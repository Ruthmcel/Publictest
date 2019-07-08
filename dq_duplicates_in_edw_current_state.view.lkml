view: dq_duplicates_in_edw_current_state {
  derived_table: {
    sql: SELECT
        *
        FROM
        (
        SELECT COUNT(*) cnt ,
          'table_name' table_name
        FROM
          (SELECT CHAIN_ID,
            NHIN_STORE_ID,
            LINE_ITEM_ID,
            COUNT(*)
          FROM edw.F_LINE_ITEM
          GROUP BY CHAIN_ID,
            NHIN_STORE_ID,
            LINE_ITEM_ID
          HAVING COUNT(*) >1
          )
        UNION ALL
        SELECT COUNT(*) D_STORE_PLAN_CNT ,
          'D_STORE_PLAN'
        FROM
          (SELECT CHAIN_ID,
            PLAN_ID,
            NHIN_STORE_ID,
            COUNT(*)
          FROM edw.D_STORE_PLAN
          GROUP BY CHAIN_ID,
            PLAN_ID,
            NHIN_STORE_ID
          HAVING COUNT(*) >1
          )
        UNION ALL
        SELECT COUNT(*) D_STORE_DRUG_CNT ,
          'D_STORE_DRUG'
        FROM
          (SELECT NHIN_STORE_ID,
            CHAIN_ID,
            DRUG_ID,
            COUNT(*)
          FROM edw.D_STORE_DRUG
         WHERE source_system_id = 4
          GROUP BY NHIN_STORE_ID,
            CHAIN_ID,
            DRUG_ID
          HAVING COUNT(*) >1
          )
        UNION ALL
        SELECT COUNT(*) D_PROGRAM_STORE_CNT ,
          'D_PROGRAM_STORE'
        FROM
          (SELECT PROGRAM_CODE,
            CHAIN_ID,
            NHIN_STORE_ID,
            COUNT(*)
          FROM edw.D_PROGRAM_STORE
          GROUP BY PROGRAM_CODE,
            CHAIN_ID,
            NHIN_STORE_ID
          HAVING COUNT(*) >1
          )
        UNION ALL
        SELECT COUNT(*) D_PATIENT_PHONE_CNT ,
          'D_PATIENT_PHONE'
        FROM
          (SELECT CHAIN_ID,
            PATIENT_PHONE_ID,
            RX_COM_ID,
            COUNT(*)
          FROM edw.D_PATIENT_PHONE
          GROUP BY CHAIN_ID,
            PATIENT_PHONE_ID,
            RX_COM_ID
          HAVING COUNT(*) >1
          )
        UNION ALL
        SELECT COUNT(*) D_PATIENT_ALLERGY_CNT ,
          'D_PATIENT_ALLERGY'
        FROM
          (SELECT PATIENT_ALLERGY_CODE,
            CHAIN_ID,
            RX_COM_ID,
            COUNT(*)
          FROM edw.D_PATIENT_ALLERGY
          GROUP BY PATIENT_ALLERGY_CODE,
            CHAIN_ID,
            RX_COM_ID
          HAVING COUNT(*) >1
          )
        UNION ALL
        SELECT COUNT(*) D_MASTER_CODE_CNT ,
          'D_MASTER_CODE'
        FROM
          (SELECT EDW_COLUMN_NAME,
            MASTER_CODE_VALUE,
            COUNT(*)
          FROM edw.D_MASTER_CODE
          GROUP BY EDW_COLUMN_NAME,
            MASTER_CODE_VALUE
          HAVING COUNT(*) >1
          )
        UNION ALL
        SELECT COUNT(*) D_ICU_FILE_CNT ,
          'D_ICU_FILE'
        FROM
          (SELECT PROGRAM_CODE,
            ICU_FILE_IDENTIFIER,
            COUNT(*)
          FROM edw.D_ICU_FILE
          GROUP BY PROGRAM_CODE,
            ICU_FILE_IDENTIFIER
          HAVING COUNT(*) >1
          )
        UNION ALL
        SELECT COUNT(*) D_ALT_PRESCRIBER_CNT ,
          'D_ALT_PRESCRIBER'
        FROM
          (SELECT ALT_PRESCRIBER_ID,
            CHAIN_ID,
            COUNT(*)
          FROM edw.D_ALT_PRESCRIBER
          GROUP BY ALT_PRESCRIBER_ID,
            CHAIN_ID
          HAVING COUNT(*) >1
          )
        UNION ALL
        SELECT COUNT(*) D_ADJUSTMENT_CODE_CNT ,
          'D_ADJUSTMENT_CODE'
        FROM
          (SELECT ADJUSTMENT_CODE_ID,
            NHIN_STORE_ID,
            CHAIN_ID,
            COUNT(*)
          FROM edw.D_ADJUSTMENT_CODE
          GROUP BY ADJUSTMENT_CODE_ID,
            NHIN_STORE_ID,
            CHAIN_ID
          HAVING COUNT(*) >1
          )
        UNION ALL
        SELECT COUNT(*) F_WORKFLOW_TOKEN_CNT ,
          'F_WORKFLOW_TOKEN'
        FROM
          (SELECT NHIN_STORE_ID,
            CHAIN_ID,
            WORKFLOW_TOKEN_ID,
            COUNT(*)
          FROM edw.F_WORKFLOW_TOKEN
          GROUP BY NHIN_STORE_ID,
            CHAIN_ID,
            WORKFLOW_TOKEN_ID
          HAVING COUNT(*) >1
          )
        UNION ALL
        SELECT COUNT(*) D_TP_LINK_CNT ,
          'D_TP_LINK'
        FROM
          (SELECT CHAIN_ID,
            TP_LINK_ID,
            COUNT(*)
          FROM edw.D_TP_LINK
          GROUP BY CHAIN_ID,
            TP_LINK_ID
          HAVING COUNT(*) >1
          )
        UNION ALL
        SELECT COUNT(*) F_RX_TX_CRED_CNT ,
          'F_RX_TX_CRED'
        FROM
          (SELECT RX_TX_CRED_ID,
            CHAIN_ID,
            COUNT(*)
          FROM edw.F_RX_TX_CRED
          GROUP BY RX_TX_CRED_ID,
            CHAIN_ID
          HAVING COUNT(*) >1
          )
        UNION ALL
        SELECT COUNT(*) F_RX_CNT ,
          'F_RX'
        FROM
          (SELECT CHAIN_ID,
            NHIN_STORE_ID,
            RX_ID,
            COUNT(*)
          FROM edw.F_RX
          WHERE source_system_id = 4
          GROUP BY CHAIN_ID,
            NHIN_STORE_ID,
            RX_ID
          HAVING COUNT(*) >1
          )
        UNION ALL
        SELECT COUNT(*) F_DRUG_LOCAL_SETTING_CNT ,
          'F_DRUG_LOCAL_SETTING'
        FROM
          (SELECT CHAIN_ID,
            NHIN_STORE_ID,
            DRUG_ID,
            COUNT(*)
          FROM edw.F_DRUG_LOCAL_SETTING
          GROUP BY CHAIN_ID,
            NHIN_STORE_ID,
            DRUG_ID
          HAVING COUNT(*) >1
          )
        UNION ALL
        SELECT COUNT(*) D_WORKFLOW_TRANSITION_CNT ,
          'D_WORKFLOW_TRANSITION'
        FROM
          (SELECT WORKFLOW_TRANSITION_ID,
            CHAIN_ID,
            NHIN_STORE_ID,
            COUNT(*)
          FROM edw.D_WORKFLOW_TRANSITION
          GROUP BY WORKFLOW_TRANSITION_ID,
            CHAIN_ID,
            NHIN_STORE_ID
          HAVING COUNT(*) >1
          )
        UNION ALL
        SELECT COUNT(*) D_WORKFLOW_STATE_CNT ,
          'D_WORKFLOW_STATE'
        FROM
          (SELECT NHIN_STORE_ID,
            WORKFLOW_STATE_ID,
            CHAIN_ID,
            COUNT(*)
          FROM edw.D_WORKFLOW_STATE
          GROUP BY NHIN_STORE_ID,
            WORKFLOW_STATE_ID,
            CHAIN_ID
          HAVING COUNT(*) >1
          )
        UNION ALL
        SELECT COUNT(*) D_STORE_ADDRESS_CNT ,
          'D_STORE_ADDRESS'
        FROM
          (SELECT CHAIN_ID,
            NHIN_STORE_ID,
            COUNT(*)
          FROM edw.D_STORE_ADDRESS
          GROUP BY CHAIN_ID,
            NHIN_STORE_ID
          HAVING COUNT(*) >1
          )
        UNION ALL
        SELECT COUNT(*) D_PROGRAM_GPI_CNT ,
          'D_PROGRAM_GPI'
        FROM
          (SELECT GPI,
            CHAIN_ID,
            PROGRAM_CODE,
            NHIN_STORE_ID,
            COUNT(*)
          FROM edw.D_PROGRAM_GPI
          GROUP BY GPI,
            CHAIN_ID,
            PROGRAM_CODE,
            NHIN_STORE_ID
          HAVING COUNT(*) >1
          )
        UNION ALL
        SELECT COUNT(*) D_PATIENT_DISEASE_CNT ,
          'D_PATIENT_DISEASE'
        FROM
          (SELECT CHAIN_ID,
            RX_COM_ID,
            DISEASE_ID,
            COUNT(*)
          FROM edw.D_PATIENT_DISEASE
          GROUP BY CHAIN_ID,
            RX_COM_ID,
            DISEASE_ID
          HAVING COUNT(*) >1
          )
        UNION ALL
        SELECT COUNT(*) D_PATIENT_ADDRESS_CNT ,
          'D_PATIENT_ADDRESS'
        FROM
          (SELECT CHAIN_ID,
            PATIENT_ADDRESS_ID,
            RX_COM_ID,
            COUNT(*)
          FROM edw.D_PATIENT_ADDRESS
          GROUP BY CHAIN_ID,
            PATIENT_ADDRESS_ID,
            RX_COM_ID
          HAVING COUNT(*) >1
          )
        UNION ALL
        SELECT COUNT(*) D_DRUG_COST_CNT ,
          'D_DRUG_COST'
        FROM
          (SELECT CHAIN_ID,
            NDC,
            DRUG_COST_TYPE,
            SOURCE_SYSTEM_ID,
            DRUG_COST_REGION,
            COUNT(*)
          FROM edw.D_DRUG_COST
          GROUP BY CHAIN_ID,
            NDC,
            DRUG_COST_TYPE,
            SOURCE_SYSTEM_ID,
            DRUG_COST_REGION
          HAVING COUNT(*) >1
          )
        UNION ALL
        SELECT COUNT(*) D_ICU_STORE_FILE_CNT ,
          'D_ICU_STORE_FILE'
        FROM
          (SELECT PROGRAM_CODE,
            NHIN_STORE_ID,
            ICU_FILE_IDENTIFIER,
            CHAIN_ID,
            COUNT(*)
          FROM edw.D_ICU_STORE_FILE
          GROUP BY PROGRAM_CODE,
            NHIN_STORE_ID,
            ICU_FILE_IDENTIFIER,
            CHAIN_ID
          HAVING COUNT(*) >1
          )
        UNION ALL
        SELECT COUNT(*) D_DRUG_UPDATE_CNT ,
          'D_DRUG_UPDATE'
        FROM
          (SELECT DRUG_UPDATE_ID,
            COUNT(*)
          FROM edw.D_DRUG_UPDATE
          GROUP BY DRUG_UPDATE_ID
          HAVING COUNT(*) >1
          )
        UNION ALL
        SELECT COUNT(*) F_TX_TP_RESPONSE_DETAIL_CNT ,
          'F_TX_TP_RESPONSE_DETAIL'
        FROM
          (SELECT CHAIN_ID,
            TX_TP_RESPONSE_DETAIL_ID,
            NHIN_STORE_ID,
            COUNT(*)
          FROM edw.F_TX_TP_RESPONSE_DETAIL
          GROUP BY CHAIN_ID,
            TX_TP_RESPONSE_DETAIL_ID,
            NHIN_STORE_ID
          HAVING COUNT(*) >1
          )
        UNION ALL
        SELECT COUNT(*) F_TRANSACTION_CNT ,
          'F_TRANSACTION'
        FROM
          (SELECT TRANSACTION_ID,
            COUNT(*)
          FROM edw.F_TRANSACTION
          GROUP BY TRANSACTION_ID
          HAVING COUNT(*) >1
          )
        UNION ALL
        SELECT COUNT(*) F_RETURN_AND_ADJUSTMENT_CNT ,
          'F_RETURN_AND_ADJUSTMENT'
        FROM
          (SELECT RETURN_AND_ADJUSTMENT_ID,
            CHAIN_ID,
            NHIN_STORE_ID,
            COUNT(*)
          FROM edw.F_RETURN_AND_ADJUSTMENT
          GROUP BY RETURN_AND_ADJUSTMENT_ID,
            CHAIN_ID,
            NHIN_STORE_ID
          HAVING COUNT(*) >1
          )
        UNION ALL
        SELECT COUNT(*) D_US_ZIP_CODE_CNT ,
          'D_US_ZIP_CODE'
        FROM
          (SELECT ZIP_CODE,
            COUNT(*)
          FROM edw.D_US_ZIP_CODE
          GROUP BY ZIP_CODE
          HAVING COUNT(*) >1
          )
        UNION ALL
        SELECT COUNT(*) D_USER_AUDIT_LOG_CNT ,
          'D_USER_AUDIT_LOG'
        FROM
          (SELECT USER_AUDIT_LOG_ID,
            COUNT(*)
          FROM edw.D_USER_AUDIT_LOG
          GROUP BY USER_AUDIT_LOG_ID
          HAVING COUNT(*) >1
          )
        UNION ALL
        SELECT COUNT(*) D_PROGRAM_FILE_UPDATE_CNT ,
          'D_PROGRAM_FILE_UPDATE'
        FROM
          (SELECT PROGRAM_FILE_UPDATE_DOCUMENT_NAME,
            PROGRAM_FILE_UPDATE_SERVICE_TYPE,
            VENDOR_ID,
            NHIN_STORE_ID,
            CHAIN_ID,
            COUNT(*)
          FROM edw.D_PROGRAM_FILE_UPDATE
          GROUP BY PROGRAM_FILE_UPDATE_DOCUMENT_NAME,
            PROGRAM_FILE_UPDATE_SERVICE_TYPE,
            VENDOR_ID,
            NHIN_STORE_ID,
            CHAIN_ID
          HAVING COUNT(*) >1
          )
        UNION ALL
        SELECT COUNT(*) D_PRESCRIBER_CNT ,
          'D_PRESCRIBER'
        FROM
          (SELECT PRESCRIBER_ID,
            CHAIN_ID,
            COUNT(*)
          FROM edw.D_PRESCRIBER
          GROUP BY PRESCRIBER_ID,
            CHAIN_ID
          HAVING COUNT(*) >1
          )
        UNION ALL
        SELECT COUNT(*) D_PLAN_CNT ,
          'D_PLAN'
        FROM
          (SELECT CHAIN_ID,
            CARRIER_CODE,
            PLAN_CODE,
            PLAN_GROUP_CODE,
            SOURCE_SYSTEM_ID,
            COUNT(*)
          FROM edw.D_PLAN
          GROUP BY CHAIN_ID,
            CARRIER_CODE,
            PLAN_CODE,
            PLAN_GROUP_CODE,
            SOURCE_SYSTEM_ID
          HAVING COUNT(*) >1
          )
        UNION ALL
        SELECT COUNT(*) D_ORDER_ENTRY_REASON_CNT ,
          'D_ORDER_ENTRY_REASON'
        FROM
          (SELECT NHIN_STORE_ID,
            ORDER_ENTRY_REASON_ID,
            CHAIN_ID,
            COUNT(*)
          FROM edw.D_ORDER_ENTRY_REASON
          GROUP BY NHIN_STORE_ID,
            ORDER_ENTRY_REASON_ID,
            CHAIN_ID
          HAVING COUNT(*) >1
          )
        UNION ALL
        SELECT COUNT(*) F_RX_TX_DIAGNOSIS_CODE_CNT ,
          'F_RX_TX_DIAGNOSIS_CODE'
        FROM
          (SELECT RX_TX_DIAGNOSIS_CODE_ID,
            CHAIN_ID,
            COUNT(*)
          FROM edw.F_RX_TX_DIAGNOSIS_CODE
          GROUP BY RX_TX_DIAGNOSIS_CODE_ID,
            CHAIN_ID
          HAVING COUNT(*) >1
          )
        UNION ALL
        SELECT COUNT(*) D_GPI_UPDATE_CNT ,
          'D_GPI_UPDATE'
        FROM
          (SELECT GPI_UPDATE_ID,
            COUNT(*)
          FROM edw.D_GPI_UPDATE
          GROUP BY GPI_UPDATE_ID
          HAVING COUNT(*) >1
          )
        UNION ALL
        SELECT COUNT(*) D_DRUG_REORDER_CNT ,
          'D_DRUG_REORDER'
        FROM
          (SELECT CHAIN_ID,
            NHIN_STORE_ID,
            DRUG_REORDER_ID,
            COUNT(*)
          FROM edw.D_DRUG_REORDER
          GROUP BY CHAIN_ID,
            NHIN_STORE_ID,
            DRUG_REORDER_ID
          HAVING COUNT(*) >1
          )
        UNION ALL
        SELECT COUNT(*) D_CARD_CNT ,
          'D_CARD'
        FROM
          (SELECT CHAIN_ID,
            CARD_ID,
            COUNT(*)
          FROM edw.D_CARD
          GROUP BY CHAIN_ID,
            CARD_ID
          HAVING COUNT(*) >1
          )
        UNION ALL
        SELECT COUNT(*) D_ADJUSTMENT_GROUP_CNT ,
          'D_ADJUSTMENT_GROUP'
        FROM
          (SELECT ADJUSTMENT_GROUP_ID,
            NHIN_STORE_ID,
            CHAIN_ID,
            COUNT(*)
          FROM edw.D_ADJUSTMENT_GROUP
          GROUP BY ADJUSTMENT_GROUP_ID,
            NHIN_STORE_ID,
            CHAIN_ID
          HAVING COUNT(*) >1
          )
        UNION ALL
        SELECT COUNT(*) F_PRIOR_AUTHORIZATION_CNT ,
          'F_PRIOR_AUTHORIZATION'
        FROM
          (SELECT PRIOR_AUTHORIZATION_ID,
            CHAIN_ID,
            COUNT(*)
          FROM edw.F_PRIOR_AUTHORIZATION
          GROUP BY PRIOR_AUTHORIZATION_ID,
            CHAIN_ID
          HAVING COUNT(*) >1
          )
        UNION ALL
        SELECT COUNT(*) D_SOURCE_SYSTEM_CNT ,
          'D_SOURCE_SYSTEM'
        FROM
          (SELECT SOURCE_SYSTEM_ID,
            COUNT(*)
          FROM edw.D_SOURCE_SYSTEM
          GROUP BY SOURCE_SYSTEM_ID
          HAVING COUNT(*) >1
          )
        UNION ALL
        SELECT COUNT(*) F_RX_TX_CNT ,
          'F_RX_TX'
        FROM
          (SELECT CHAIN_ID,
            RX_TX_ID,
            COUNT(*)
          FROM edw.F_RX_TX
          GROUP BY CHAIN_ID,
            RX_TX_ID
          HAVING COUNT(*) >1
          )
        UNION ALL
        SELECT COUNT(*) F_PACKAGE_INFORMATION_CNT ,
          'F_PACKAGE_INFORMATION'
        FROM
          (SELECT CHAIN_ID,
            PACKAGE_INFORMATION_ID,
            COUNT(*)
          FROM edw.F_PACKAGE_INFORMATION
          GROUP BY CHAIN_ID,
            PACKAGE_INFORMATION_ID
          HAVING COUNT(*) >1
          )
        UNION ALL
        SELECT COUNT(*) F_ORDER_ENTRY_CNT ,
          'F_ORDER_ENTRY'
        FROM
          (SELECT CHAIN_ID,
            ORDER_ENTRY_ID,
            NHIN_STORE_ID,
            COUNT(*)
          FROM edw.F_ORDER_ENTRY
          GROUP BY CHAIN_ID,
            ORDER_ENTRY_ID,
            NHIN_STORE_ID
          HAVING COUNT(*) >1
          )
        UNION ALL
        SELECT COUNT(*) D_PICKUP_TYPE_CNT ,
          'D_PICKUP_TYPE'
        FROM
          (SELECT PICKUP_TYPE_ID,
            NHIN_STORE_ID,
            CHAIN_ID,
            COUNT(*)
          FROM edw.D_PICKUP_TYPE
          GROUP BY PICKUP_TYPE_ID,
            NHIN_STORE_ID,
            CHAIN_ID
          HAVING COUNT(*) >1
          )
        UNION ALL
        SELECT COUNT(*) D_GPI_CNT ,
          'D_GPI'
        FROM
          (SELECT CHAIN_ID,
            SOURCE_SYSTEM_ID,
            GPI,
            COUNT(*)
          FROM edw.D_GPI
          GROUP BY CHAIN_ID,
            SOURCE_SYSTEM_ID,
            GPI
          HAVING COUNT(*) >1
          )
        UNION ALL
        SELECT COUNT(*) D_DRUG_EXCLUSION_CNT ,
          'D_DRUG_EXCLUSION'
        FROM
          (SELECT NDC,
            COUNT(*)
          FROM edw.D_DRUG_EXCLUSION
          GROUP BY NDC
          HAVING COUNT(*) >1
          )
        UNION ALL
        SELECT COUNT(*) D_ADDRESS_CNT ,
          'D_ADDRESS'
        FROM
          (SELECT CHAIN_ID,
            NHIN_STORE_ID,
            ADDRESS_ID,
            COUNT(*)
          FROM edw.D_ADDRESS
          GROUP BY CHAIN_ID,
            NHIN_STORE_ID,
            ADDRESS_ID
          HAVING COUNT(*) >1
          )
        UNION ALL
        SELECT COUNT(*) D_STORE_VENDOR_CNT ,
          'D_STORE_VENDOR'
        FROM
          (SELECT VENDOR_ID,
            CHAIN_ID,
            NHIN_STORE_ID,
            COUNT(*)
          FROM edw.D_STORE_VENDOR
          GROUP BY VENDOR_ID,
            CHAIN_ID,
            NHIN_STORE_ID
          HAVING COUNT(*) >1
          )
        UNION ALL
        SELECT COUNT(*) F_TASK_HISTORY_CNT ,
          'F_TASK_HISTORY'
        FROM
          (SELECT TASK_HISTORY_ID,
            NHIN_STORE_ID,
            CHAIN_ID,
            COUNT(*)
          FROM edw.F_TASK_HISTORY
          GROUP BY TASK_HISTORY_ID,
            NHIN_STORE_ID,
            CHAIN_ID
          HAVING COUNT(*) >1
          )
        UNION ALL
        SELECT COUNT(*) F_RX_TX_ACTIVE_CNT ,
          'F_RX_TX_ACTIVE'
        FROM
          (SELECT NHIN_STORE_ID,
            CHAIN_ID,
            RX_TX_ID,
            COUNT(*)
          FROM edw.F_RX_TX_ACTIVE
          GROUP BY NHIN_STORE_ID,
            CHAIN_ID,
            RX_TX_ID
          HAVING COUNT(*) >1
          )
        UNION ALL
        SELECT COUNT(*) D_VENDOR_CNT ,
          'D_VENDOR'
        FROM
          (SELECT SOURCE_SYSTEM_ID,
            VENDOR_ID,
            COUNT(*)
          FROM edw.D_VENDOR
          GROUP BY SOURCE_SYSTEM_ID,
            VENDOR_ID
          HAVING COUNT(*) >1
          )
        UNION ALL
        SELECT COUNT(*) D_STORE_CNT ,
          'D_STORE'
        FROM
          (SELECT SOURCE_SYSTEM_ID,
            CHAIN_ID,
            NHIN_STORE_ID,
            COUNT(*)
          FROM edw.D_STORE
          GROUP BY SOURCE_SYSTEM_ID,
            CHAIN_ID,
            NHIN_STORE_ID
          HAVING COUNT(*) >1
          )
        UNION ALL
        SELECT COUNT(*) D_PROGRAM_DRUG_CNT ,
          'D_PROGRAM_DRUG'
        FROM
          (SELECT PROGRAM_CODE,
            NDC,
            NHIN_STORE_ID,
            CHAIN_ID,
            COUNT(*)
          FROM edw.D_PROGRAM_DRUG
          GROUP BY PROGRAM_CODE,
            NDC,
            NHIN_STORE_ID,
            CHAIN_ID
          HAVING COUNT(*) >1
          )
        UNION ALL
        SELECT COUNT(*) D_PRODUCT_CNT ,
          'D_PRODUCT'
        FROM
          (SELECT PRODUCT_NAME,
            COUNT(*)
          FROM edw.D_PRODUCT
          GROUP BY PRODUCT_NAME
          HAVING COUNT(*) >1
          )
        UNION ALL
        SELECT COUNT(*) D_STORE_PLAN_TRANSMIT_CNT ,
          'D_STORE_PLAN_TRANSMIT'
        FROM
          (SELECT PLAN_TRANSMIT_ID,
            NHIN_STORE_ID,
            CHAIN_ID,
            COUNT(*)
          FROM edw.D_STORE_PLAN_TRANSMIT
          GROUP BY PLAN_TRANSMIT_ID,
            NHIN_STORE_ID,
            CHAIN_ID
          HAVING COUNT(*) >1
          )
        UNION ALL
        SELECT COUNT(*) D_PATIENT_MTM_ELIGIBILITY_CNT ,
          'D_PATIENT_MTM_ELIGIBILITY'
        FROM
          (SELECT RX_COM_ID,
            CHAIN_ID,
            PATIENT_MTM_ID,
            COUNT(*)
          FROM edw.D_PATIENT_MTM_ELIGIBILITY
          GROUP BY RX_COM_ID,
            CHAIN_ID,
            PATIENT_MTM_ID
          HAVING COUNT(*) >1
          )
        UNION ALL
        SELECT COUNT(*) D_CHAIN_CNT ,
          'D_CHAIN'
        FROM
          (SELECT CHAIN_ID,
            SOURCE_SYSTEM_ID,
            COUNT(*)
          FROM edw.D_CHAIN
          GROUP BY CHAIN_ID,
            SOURCE_SYSTEM_ID
          HAVING COUNT(*) >1
          )
        UNION ALL
        SELECT COUNT(*) F_TX_TP_LINK_CNT ,
          'F_TX_TP_LINK'
        FROM
          (SELECT NHIN_STORE_ID,
            TX_TP_ID,
            CHAIN_ID,
            COUNT(*)
          FROM edw.F_TX_TP_LINK
          GROUP BY NHIN_STORE_ID,
            TX_TP_ID,
            CHAIN_ID
          HAVING COUNT(*) >1
          )
        UNION ALL
        SELECT COUNT(*) F_TX_LOT_NUMBER_CNT ,
          'F_TX_LOT_NUMBER'
        FROM
          (SELECT TX_LOT_NUMBER_ID,
            CHAIN_ID,
            COUNT(*)
          FROM edw.F_TX_LOT_NUMBER
          GROUP BY TX_LOT_NUMBER_ID,
            CHAIN_ID
          HAVING COUNT(*) >1
          )
        UNION ALL
        SELECT COUNT(*) F_TRANSACTION_DOCUMENT_CNT ,
          'F_TRANSACTION_DOCUMENT'
        FROM
          (SELECT TRANSACTION_ID,
            DOCUMENT_IDENTIFIER,
            PROGRAM_CODE,
            COUNT(*)
          FROM edw.F_TRANSACTION_DOCUMENT
          GROUP BY TRANSACTION_ID,
            DOCUMENT_IDENTIFIER,
            PROGRAM_CODE
          HAVING COUNT(*) >1
          )
        UNION ALL
        SELECT COUNT(*) F_RX_TX_LINK_CNT ,
          'F_RX_TX_LINK'
        FROM
          (SELECT CHAIN_ID,
            RX_TX_ID,
            NHIN_STORE_ID,
            COUNT(*)
          FROM edw.F_RX_TX_LINK
          WHERE source_system_id = 4
          GROUP BY CHAIN_ID,
            RX_TX_ID,
            NHIN_STORE_ID
          HAVING COUNT(*) >1
          )
        UNION ALL
        SELECT COUNT(*) F_DRUG_ORDER_CNT ,
          'F_DRUG_ORDER'
        FROM
          (SELECT CHAIN_ID,
            NHIN_STORE_ID,
            DRUG_ORDER_ID,
            COUNT(*)
          FROM edw.F_DRUG_ORDER
          GROUP BY CHAIN_ID,
            NHIN_STORE_ID,
            DRUG_ORDER_ID
          HAVING COUNT(*) >1
          )
        UNION ALL
        SELECT COUNT(*) D_PHONE_CNT ,
          'D_PHONE'
        FROM
          (SELECT PHONE_ID,
            CHAIN_ID,
            NHIN_STORE_ID,
            COUNT(*)
          FROM edw.D_PHONE
          GROUP BY PHONE_ID,
            CHAIN_ID,
            NHIN_STORE_ID
          HAVING COUNT(*) >1
          )
        UNION ALL
        SELECT COUNT(*) D_PATIENT_MEDICAL_CONDITION_CNT ,
          'D_PATIENT_MEDICAL_CONDITION'
        FROM
          (SELECT CHAIN_ID,
            RX_COM_ID,
            MEDICAL_CONDITION_ID,
            COUNT(*)
          FROM edw.D_PATIENT_MEDICAL_CONDITION
          GROUP BY CHAIN_ID,
            RX_COM_ID,
            MEDICAL_CONDITION_ID
          HAVING COUNT(*) >1
          )
        UNION ALL
        SELECT COUNT(*) D_PATIENT_CNT ,
          'D_PATIENT'
        FROM
          (SELECT RX_COM_ID,
            CHAIN_ID,
            COUNT(*)
          FROM edw.D_PATIENT
          GROUP BY RX_COM_ID,
            CHAIN_ID
          HAVING COUNT(*) >1
          )
        UNION ALL
        SELECT COUNT(*) F_TX_TP_RESPONSE_DETAIL_AMOUNT_CNT ,
          'F_TX_TP_RESPONSE_DETAIL_AMOUNT'
        FROM
          (SELECT TX_TP_RESPONSE_DETAIL_AMOUNT_ID,
            CHAIN_ID,
            NHIN_STORE_ID,
            COUNT(*)
          FROM edw.F_TX_TP_RESPONSE_DETAIL_AMOUNT
          GROUP BY TX_TP_RESPONSE_DETAIL_AMOUNT_ID,
            CHAIN_ID,
            NHIN_STORE_ID
          HAVING COUNT(*) >1
          )
        UNION ALL
        SELECT COUNT(*) D_WORKFLOW_TYPE_CNT ,
          'D_WORKFLOW_TYPE'
        FROM
          (SELECT NHIN_STORE_ID,
            CHAIN_ID,
            WORKFLOW_TYPE_ID,
            COUNT(*)
          FROM edw.D_WORKFLOW_TYPE
          GROUP BY NHIN_STORE_ID,
            CHAIN_ID,
            WORKFLOW_TYPE_ID
          HAVING COUNT(*) >1
          )
        UNION ALL
        SELECT COUNT(*) F_PRINT_TRANSACTION_CNT ,
          'F_PRINT_TRANSACTION'
        FROM
          (SELECT PRINT_TRANSACTION_ID,
            COUNT(*)
          FROM edw.F_PRINT_TRANSACTION
          GROUP BY PRINT_TRANSACTION_ID
          HAVING COUNT(*) >1
          )
        UNION ALL
        SELECT COUNT(*) D_WORKFLOW_STATE_ATTRIBUTE_CNT ,
          'D_WORKFLOW_STATE_ATTRIBUTE'
        FROM
          (SELECT NHIN_STORE_ID,
            CHAIN_ID,
            WORKFLOW_STATE_ATTRIBUTE_ID,
            COUNT(*)
          FROM edw.D_WORKFLOW_STATE_ATTRIBUTE
          GROUP BY NHIN_STORE_ID,
            CHAIN_ID,
            WORKFLOW_STATE_ATTRIBUTE_ID
          HAVING COUNT(*) >1
          )
        UNION ALL
        SELECT COUNT(*) D_PHARMACY_CNT ,
          'D_PHARMACY'
        FROM
          (SELECT CHAIN_ID,
            NHIN_STORE_ID,
            PHARMACY_ID,
            COUNT(*)
          FROM edw.D_PHARMACY
          GROUP BY CHAIN_ID,
            NHIN_STORE_ID,
            PHARMACY_ID
          HAVING COUNT(*) >1
          )
        UNION ALL
        SELECT COUNT(*) D_PATIENT_GPI_PDC_CNT ,
          'D_PATIENT_GPI_PDC'
        FROM
          (SELECT GPI,
            SNAPSHOT_DATE,
            CHAIN_ID,
            RX_COM_ID,
            MEDICAL_CONDITION,
            COUNT(*)
          FROM edw.D_PATIENT_GPI_PDC
          GROUP BY GPI,
            SNAPSHOT_DATE,
            CHAIN_ID,
            RX_COM_ID,
            MEDICAL_CONDITION
          HAVING COUNT(*) >1
          )
        UNION ALL
        SELECT COUNT(*) D_PATIENT_EMAIL_CNT ,
          'D_PATIENT_EMAIL'
        FROM
          (SELECT CHAIN_ID,
            PATIENT_EMAIL_ADDRESS,
            RX_COM_ID,
            COUNT(*)
          FROM edw.D_PATIENT_EMAIL
          GROUP BY CHAIN_ID,
            PATIENT_EMAIL_ADDRESS,
            RX_COM_ID
          HAVING COUNT(*) >1
          )
        UNION ALL
        SELECT COUNT(*) D_GPI_MEDICAL_CONDITION_CROSS_REF_CNT ,
          'D_GPI_MEDICAL_CONDITION_CROSS_REF'
        FROM
          (SELECT MEDICAL_CONDITION,
            GPI,
            COUNT(*)
          FROM edw.D_GPI_MEDICAL_CONDITION_CROSS_REF
          GROUP BY MEDICAL_CONDITION,
            GPI
          HAVING COUNT(*) >1
          )
        UNION ALL
        SELECT COUNT(*) D_DRUG_COST_TYPE_CNT ,
          'D_DRUG_COST_TYPE'
        FROM
          (SELECT SOURCE_SYSTEM_ID,
            DRUG_COST_TYPE,
            CHAIN_ID,
            COUNT(*)
          FROM edw.D_DRUG_COST_TYPE
          GROUP BY SOURCE_SYSTEM_ID,
            DRUG_COST_TYPE,
            CHAIN_ID
          HAVING COUNT(*) >1
          )
        UNION ALL
        SELECT COUNT(*) F_WORKFLOW_HISTORY_CNT ,
          'F_WORKFLOW_HISTORY'
        FROM
          (SELECT WORKFLOW_HISTORY_ID,
            NHIN_STORE_ID,
            CHAIN_ID,
            COUNT(*)
          FROM edw.F_WORKFLOW_HISTORY
          GROUP BY WORKFLOW_HISTORY_ID,
            NHIN_STORE_ID,
            CHAIN_ID
          HAVING COUNT(*) >1
          )
        UNION ALL
        SELECT COUNT(*) F_TX_TP_SUBMIT_DETAIL_CNT ,
          'F_TX_TP_SUBMIT_DETAIL'
        FROM
          (SELECT TX_TP_SUBMIT_DETAIL_ID,
            CHAIN_ID,
            NHIN_STORE_ID,
            COUNT(*)
          FROM edw.F_TX_TP_SUBMIT_DETAIL
          GROUP BY TX_TP_SUBMIT_DETAIL_ID,
            CHAIN_ID,
            NHIN_STORE_ID
          HAVING COUNT(*) >1
          )
        UNION ALL
        SELECT COUNT(*) D_DRUG_CNT ,
          'D_DRUG'
        FROM
          (SELECT SOURCE_SYSTEM_ID,
            NDC,
            CHAIN_ID,
            COUNT(*)
          FROM edw.D_DRUG
          GROUP BY SOURCE_SYSTEM_ID,
            NDC,
            CHAIN_ID
          HAVING COUNT(*) >1
          )
        UNION ALL
        SELECT COUNT(*) F_TX_TP_CNT ,
          'F_TX_TP'
        FROM
          (SELECT CHAIN_ID,
            TX_TP_ID,
            COUNT(*)
          FROM edw.F_TX_TP
          GROUP BY CHAIN_ID,
            TX_TP_ID
          HAVING COUNT(*) >1
          )
        UNION ALL
        SELECT COUNT(*) D_STORE_LICENSE_CNT ,
          'D_STORE_LICENSE'
        FROM
          (SELECT NHIN_STORE_ID,
            CHAIN_ID,
            STORE_LICENSE_NAME,
            SOURCE_SYSTEM_ID,
            COUNT(*)
          FROM edw.D_STORE_LICENSE
          GROUP BY NHIN_STORE_ID,
            CHAIN_ID,
            STORE_LICENSE_NAME,
            SOURCE_SYSTEM_ID
          HAVING COUNT(*) >1
          )
        UNION ALL
        SELECT COUNT(*) D_PROGRAM_CNT ,
          'D_PROGRAM'
        FROM
          (SELECT PROGRAM_CODE,
            COUNT(*)
          FROM edw.D_PROGRAM
          GROUP BY PROGRAM_CODE
          HAVING COUNT(*) >1
          )
        UNION ALL
        SELECT COUNT(*) D_GPI_DISEASE_CROSS_REF_CNT ,
          'D_GPI_DISEASE_CROSS_REF'
        FROM
          (SELECT DISEASE_CODE,
            GPI,
            INDICATION_CODE,
            COUNT(*)
          FROM edw.D_GPI_DISEASE_CROSS_REF
          GROUP BY DISEASE_CODE,
            GPI,
            INDICATION_CODE
          HAVING COUNT(*) >1
          )
        UNION ALL
        SELECT COUNT(*) D_DOCUMENT_CNT ,
          'D_DOCUMENT'
        FROM
          (SELECT DOCUMENT_IDENTIFIER,
            PROGRAM_CODE,
            COUNT(*)
          FROM edw.D_DOCUMENT
          GROUP BY DOCUMENT_IDENTIFIER,
            PROGRAM_CODE
          HAVING COUNT(*) >1
          )
        UNION ALL
        SELECT COUNT(*) D_CONTACT_INFORMATION_CNT ,
          'D_CONTACT_INFORMATION'
        FROM
          (SELECT SOURCE_SYSTEM_ID,
            CONTACT_INFO_ID,
            COUNT(*)
          FROM edw.D_CONTACT_INFORMATION
          GROUP BY SOURCE_SYSTEM_ID,
            CONTACT_INFO_ID
          HAVING COUNT(*) >1
          )
        UNION ALL
        SELECT COUNT(*) F_SHIPMENT_CNT ,
          'F_SHIPMENT'
        FROM
          (SELECT SHIPMENT_ID,
            NHIN_STORE_ID,
            CHAIN_ID,
            COUNT(*)
          FROM edw.F_SHIPMENT
          GROUP BY SHIPMENT_ID,
            NHIN_STORE_ID,
            CHAIN_ID
          HAVING COUNT(*) >1
          )
        UNION ALL
        SELECT COUNT(*) F_PURCHASE_ORDER_CNT ,
          'F_PURCHASE_ORDER'
        FROM
          (SELECT PURCHASE_ORDER_ID,
            CHAIN_ID,
            NHIN_STORE_ID,
            COUNT(*)
          FROM edw.F_PURCHASE_ORDER
          GROUP BY PURCHASE_ORDER_ID,
            CHAIN_ID,
            NHIN_STORE_ID
          HAVING COUNT(*) >1
          )
        UNION ALL
        SELECT COUNT(*) D_STORE_PRODUCT_VENDOR_CNT ,
          'D_STORE_PRODUCT_VENDOR'
        FROM
          (SELECT CHAIN_ID,
            PRODUCT_NAME,
            NHIN_STORE_ID,
            VENDOR_ID,
            COUNT(*)
          FROM edw.D_STORE_PRODUCT_VENDOR
          GROUP BY CHAIN_ID,
            PRODUCT_NAME,
            NHIN_STORE_ID,
            VENDOR_ID
          HAVING COUNT(*) >1
          ) )
        where cnt!=0
       ;;
  }

  ################################################################################################## Dimensions ################################################################################################


  dimension: cnt {
    label: "Duplicate Table Count"
    description: "Duplicate table count"
    type: number
    sql: ${TABLE}.cnt ;;
  }

  dimension: table_name {
    label: "Table Name"
    description: "Table Name"
    type: string
    sql: ${TABLE}.table_name ;;
  }
}

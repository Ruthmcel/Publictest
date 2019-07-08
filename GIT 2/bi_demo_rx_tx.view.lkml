view: bi_demo_rx_tx {
    derived_table: {
      sql: SELECT
         EPR.CHAIN_ID,
         EPR.NHIN_STORE_ID,
         EPR.RX_TX_RX_NUMBER,
         EPR.RX_TX_TX_NUMBER,
         EPR.RX_COM_ID,
         EPR.RX_TX_NEW_RX_NUMBER,
         EPR.RX_TX_OLD_RX_NUMBER,
         DECODE(EPS.NHIN_STORE_ID,NULL,EPR.RX_TX_REFILL_NUMBER,EPS.RX_TX_REFILL_NUMBER) AS RX_TX_REFILL_NUMBER,
         DECODE(EPS.NHIN_STORE_ID,NULL,EPR.RX_TX_RX_STATUS,EPS.RX_STATUS) AS RX_TX_RX_STATUS,
         DECODE(EPS.NHIN_STORE_ID,NULL,EPR.RX_TX_TX_STATUS,EPS.RX_TX_TX_STATUS) AS RX_TX_TX_STATUS,
         DECODE(EPS.NHIN_STORE_ID,NULL,EPR.RX_TX_FILL_STATUS,EPS.RX_TX_FILL_STATUS) AS RX_TX_FILL_STATUS,
         DECODE(EPS.NHIN_STORE_ID,NULL,EPR.RX_TX_PARTIAL_FILL_STATUS,EPS.RX_TX_PARTIAL_FILL_STATUS) AS RX_TX_PARTIAL_FILL_STATUS,
         DECODE(EPS.NHIN_STORE_ID,NULL,EPR.RX_TX_TAX_AMOUNT,EPS.RX_TX_TAX_AMOUNT) AS RX_TX_TAX_AMOUNT,
         DECODE(EPS.NHIN_STORE_ID,NULL,EPR.RX_TX_DISCOUNT_AMOUNT,EPS.DISCOUNT) AS RX_TX_DISCOUNT_AMOUNT,
         DECODE(EPS.NHIN_STORE_ID,NULL,EPR.RX_TX_PRICE,EPS.PRICE) AS RX_TX_PRICE,
         DECODE(EPS.NHIN_STORE_ID,NULL,EPR.RX_TX_ACQUISITION_COST,EPS.ACQUISITION_COST) AS RX_TX_ACQUISITION_COST,
         DECODE(EPS.NHIN_STORE_ID,NULL,EPR.RX_TX_PRICE-EPR.RX_TX_ACQUISITION_COST,EPS.PRICE-EPS.ACQUISITION_COST) AS RX_TX_GROSS_MARGIN,
         DECODE(EPS.NHIN_STORE_ID,NULL,EPR.RX_TX_UC_PRICE,EPS.RX_TX_UC_PRICE) AS RX_TX_UC_PRICE,
         DECODE(EPS.NHIN_STORE_ID,NULL,EPR.RX_TX_FILL_QUANTITY,EPS.RX_TX_FILL_QUANTITY) AS RX_TX_FILL_QUANTITY,
         DECODE(EPS.NHIN_STORE_ID,NULL,EPR.RX_TX_TP_BILL,EPS.RX_TX_TP_BILL) AS RX_TX_TP_BILL,
         DECODE(EPS.NHIN_STORE_ID,NULL,EPR.RX_TX_SOLD_DATE,EPS.RX_TX_WILL_CALL_PICKED_UP_DATE) AS RX_TX_SOLD_DATE,
         DECODE(EPS.NHIN_STORE_ID,NULL,DECODE(EPR.RX_TX_REPORTABLE_SALES_DATE,NULL,EPR.RX_TX_FILLED_DATE),EPS.RX_TX_REPORTABLE_SALES_DATE) AS RX_TX_REPORTABLE_SALES_DATE, -- With Regard to Reportable Sales Date from EPR,
         DECODE(EPS.NHIN_STORE_ID,NULL,EPR.RX_TX_FILLED_DATE,EPS.RX_TX_FILL_DATE) AS RX_TX_FILLED_DATE,
         EPS.RX_TX_POS_SOLD_DATE,
         EPS.RX_TX_WILL_CALL_ARRIVAL_DATE,
         EPS.RX_TX_RETURNED_DATE,
         'Active' AS ACTIVE_OR_NON_ACTIVE,
         EPS.RX_SOURCE,
         EPS.RX_ON_FILE,
         EPS.RX_TRANSFER_OUT_FILL_COUNT,
         EPS.RX_PRESCRIBED_DAYS_SUPPLY,
         EPS.RX_MERGED_TO_DATE,
         EPS.RX_AUTOFILL_ENABLE_DATE,
         EPS.RX_RECEIVED_DATE,
         EPS.RX_NCPDP_ROUTE,
         EPS.RX_WHOLESALE_ORDER_FLAG,
         EPS.RX_CONTROLLED_SUBSTANCE_ESCRIPT_FLAG,
         EPS.RX_FILE_BUY_DATE,
         EPS.RX_TX_POS_STATUS,
         EPS.RX_TX_IS_340B,
         EPS.RX_TX_PARTIAL_FILL_BILL_TYPE,
         EPR.PRESCRIBER_ID,
         EPR.RX_TX_MODPCM_ID,
         EPR.RX_TX_ACS_PRIORITY,
         EPR.RX_TX_ALLERGY_OVERRIDE,
         EPR.RX_TX_ALTERNATE_DOCTOR,
         EPR.RX_TX_CHARGE,
         EPR.RX_TX_COMPOUND_FEE,
         EPR.RX_TX_COST,
         EPR.RX_TX_COUNSELING_CHOICE,
         EPR.RX_TX_NCPDP_DAW,
         EPR.RX_TX_QUANTITY,
         EPR.RX_TX_DECIMAL_QUANTITY,
         EPR.RX_TX_DOSE_COVER,
         EPR.RX_TX_DRUG_CODE,
         EPR.RX_TX_DRUG_EXPIRATION_DATE,
         EPR.RX_TX_DUPLICATE_THERAPY,
         EPR.RX_TX_DUR_OVERRIDE,
         EPR.RX_TX_NOT_PICKED_UP_YET,
         EPR.RX_TX_HOST_RETRIEVAL_DATE,
         EPR.RX_TX_INITIALS,
         EPR.RX_TX_INTERACTION_OVERRIDE,
         EPR.RX_TX_TX_MESSAGE,
         EPR.RX_TX_MANUFACTURER,
         EPR.RX_TX_NDC,
         EPR.RX_TX_NSC_CHOICE,
         EPR.RX_TX_ORDER_INITIALS,
         EPR.RX_TX_OTHER_PRICE,
         EPR.RX_TX_PAC_MED,
         EPR.RX_TX_PATIENT_DISEASE_OVERRIDE,
         EPR.RX_TX_PHYSICIAN_CODE,
         EPR.RX_TX_POS_TYPE,
         EPR.RX_TX_PRICE_CODE,
         EPR.RX_TX_RPH_COUNSELLING_INITIALS,
         EPR.RX_TX_SCHED_DRUG_REPORT_DATE,
         EPR.RX_TX_SIG_CODE,
         EPR.RX_TX_TAX_CODE,
         EPR.RX_TX_TECH_INITIALS,
         EPR.RX_TX_UP_CHARGE,
         EPR.RX_TX_USUAL,
         EPR.RX_TX_VIA_PREFILL,
         EPR.RX_TX_PRESCRIBED_DRUG_GPI,
         EPR.RX_TX_PRESCRIBED_DRUG_NDC,
         EPR.RX_TX_PRESCRIBED_DRUG_NAME,
         EPR.RX_TX_DISPENSED_DRUG_GPI,
         EPR.RX_TX_DISPENSED_DRUG_NDC,
         EPR.RX_TX_DISPENSED_DRUG_NAME,
         EPR.RX_TX_COMPOUND,
         EPR.RX_TX_DOCTOR_DAW,
         EPR.RX_TX_DAYS_SUPPLY,
         EPR.RX_TX_DRUG_SCHEDULE,
         EPR.RX_TX_DAYS_SUPPLY_BASIS,
         EPR.RX_TX_DAYS_SUPPLY_CODE,
         EPR.RX_TX_EXPIRATION_DATE,
         EPR.RX_TX_FIRST_FILLED_DATE,
         EPR.RX_TX_FOLLOW_UP_DATE,
         EPR.RX_TX_FORCE_COG,
         EPR.RX_TX_GROUP_CODE,
         EPR.RX_TX_ICD9_CODE,
         EPR.RX_TX_ICD9_TYPE,
         EPR.RX_TX_NUMBER_OF_LABELS,
         EPR.RX_TX_REMAINING_QUANTITY,
         EPR.RX_TX_REMAINING_DECIMAL_QTY,
         EPR.RX_TX_ORIGINAL_WRITTEN_DATE,
         EPR.RX_TX_OTHER_NHIN_STORE_ID,
         EPR.RX_TX_OWED_QUANTITY,
         EPR.RX_TX_PATIENT_CODE,
         EPR.RX_TX_AUTHORIZED_VIA_PHONE,
         EPR.RX_TX_CREATED_VIA_PHONE,
         EPR.RX_TX_AUTOFILL_MAIL,
         EPR.RX_TX_AUTOFILL,
         EPR.RX_TX_AUTOFILL_QUANTITY,
         EPR.RX_TX_AUTOFILL_DECIMAL_QTY,
         EPR.RX_TX_TRANSFER,
         EPR.RX_TX_REFILLS_AUTHORIZED,
         EPR.RX_TX_REFILLS_REMAINING,
         EPR.RX_TX_REFILLS_TRANSFERRED,
         EPR.RX_TX_STOP_DATE,
         EPR.RX_TX_SUBSTITUTE,
         EPR.RX_TX_WHY_DEACTIVATED,
         EPR.RX_TX_WRITTEN_DATE,
         EPR.RX_TX_ARCHIVE_DATE,
         EPR.RX_TX_SIG_LANGUAGE,
         EPR.RX_TX_SIG_PER_DAY,
         EPR.RX_TX_SIG_PER_DOSE,
         EPR.RX_TX_SIG_TEXT,
         EPR.RX_TX_SIG_TEXT_FOREIGN_LANG,
         EPR.RX_TX_LOST,
         EPR.RX_TX_PV_INITIALS,
         EPR.RX_TX_CALL_FOR_REFILLS,
         EPR.RX_TX_DRUG_IMAGE_KEY,
         EPR.RX_TX_HAS_TX_CREDS,
         EPR.RX_TX_HAS_TX_TPS,
         EPR.RX_TX_MRN_LOCATION_CODE,
         EPR.RX_TX_MRN_ID,
         EPR.RX_TX_SENDING_APPLICATION,
         EPR.RX_TX_PRESCRIBER_ORDER_NUMBER,
         EPR.RX_TX_REFILL_QUANTITY,
         EPR.RX_TX_RX_START_DATE,
         EPR.RX_TX_CONFIDENTIALITY_IND,
         EPR.RX_TX_WORKERS_COMP,
         EPR.RX_TX_RX_SERIAL_NUMBER,
         EPR.RX_TX_SHIPPER_NAME,
         EPR.RX_TX_SHIPPER_TRACKING_NUMBER,
         EPR.RX_TX_SHIP_DATE,
         EPR.RX_TX_CANCEL_REASON,
         EPR.RX_TX_INTERACTION_RX_SOURCE,
         EPR.RX_TX_ACTIVE_MEMBER,
         EPR.RX_TX_WILL_CALL_READY,
         EPR.RX_TX_ENTERPRISE_RX_FILL_COUNT,
         EPR.RX_TX_RX_STATE,
         EPR.RX_TX_TEEN_CONFIDENTIAL,
         EPR.RX_TX_PRESCRIBED_DECIMAL_QTY,
         EPR.RX_TX_FILL_DECIMAL_QUANTITY,
         EPR.RX_TX_RENEWED_RX,
         EPR.RX_TX_COUNSEL_REASON,
         EPR.RX_TX_THERAPEUTIC_CONVERSION,
         EPR.RX_TX_BENEFITS_RIGHTS_LETTER,
         EPR.RX_TX_HAS_COMPOUND_INGREDIENTS,
         EPR.RX_TX_RX_NOTE,
         EPR.RX_TX_TX_NOTE,
         EPR.RX_TX_DEACT_RX_USER_LAST_NAME,
         EPR.RX_TX_DEACT_RX_USER_FIRST_NAME,
         EPR.RX_TX_DEACT_RX_USER_EMP_NUM,
         EPR.RX_TX_DEACTIVATE_RX_DATE,
         EPR.RX_TX_LANG_MANUALLY_SELECTED,
         EPR.RX_TX_LOCAL_MAIL,
         EPR.RX_TX_UNVERIFIED_RX,
         EPR.RX_TX_POS_OVERRIDDEN_NET_PAID,
         EPR.RX_TX_SYNC_SCRIPT_ENROLLMENT,
         EPR.RX_TX_SYNC_SCRIPT_ENROLLED_DT,
         EPR.RX_TX_SYNC_SCRIPT_ENROLLED_BY,
         EPR.RX_TX_SIG_CHANGE_USER_INITIALS,
         EPR.RX_TX_SIG_TEXT_CHANGED,
         EPR.RX_TX_INTERACTION_CODE,
         EPR.RX_TX_CHECK_RX_OVERWRITTEN,
         EPR.RX_TX_PATIENT_START_DATE,
         EPR.RX_TX_LAST_MESSAGE_SOURCE,
         EPR.RX_TX_SPI_IDENTIFIER,
         EPR.RX_TX_IMMUNIZATION_INDICATOR,
         EPR.RX_TX_DISP_DRUG_UNIT,
         EPR.RX_TX_CVX_CODE,
         EPR.RX_TX_CPT_CODE,
         EPR.RX_TX_MVX_CODE,
         EPR.RX_TX_CLINIC_REFERENCE_NUMBER,
         EPR.RX_TX_RXFILL_INDICATOR,
         EPR.RX_TX_RX_DELETED,
         EPR.RX_TX_TX_DELETED,
         EPR.RX_TX_LCR_ID AS EPR_RX_TX_LCR_ID,
         EPR.RX_TX_ID AS EPR_RX_TX_ID,
         EPS.RX_TX_ID AS EPS_RX_TX_ID,
         EPR.SOURCE_TIMESTAMP AS EPR_SOURCE_TIMESTAMP,
         DECODE(EPS.NHIN_STORE_ID,NULL,EPR.RX_TX_WILL_CALL_PICKED_UP_DATE,EPS.RX_TX_WILL_CALL_PICKED_UP_DATE) AS RX_TX_WILL_CALL_PICKED_UP_DATE,   -- WIll Call Picked Up Date in EPR is always populated only from WinPDX. Currently EPS is not populating once EPS fixes their application, this date will start populating
         EPR.RX_TX_ORDER_CLASS,
         EPR.RX_TX_ORDER_TYPE,
         EPR.RX_TX_PRINT_DRUG_NAME,
         EPR.RX_TX_PROGRAM_ADD,
         EPR.RX_TX_SPECIALTY,
         EPR.RX_TX_ROUTE_OF_ADMINISTRATION,
         EPR.RX_TX_SITE_OF_ADMINISTRATION,
         EPR.AUDIT_ACCESS_LOG_ID,
         DATEDIFF(DAY,MAX(RX_TX_FILLED_DATE) OVER (PARTITION BY EPR.CHAIN_ID,EPR.RX_COM_ID),CURRENT_TIMESTAMP) AS DAYS_SINCE_LAST_ACTIVITY,
         CASE  WHEN {% condition sold_date_filter %} DECODE(EPS.NHIN_STORE_ID,NULL,EPR.RX_TX_SOLD_DATE,EPS.RX_TX_WILL_CALL_PICKED_UP_DATE) {% endcondition %}
               AND {% condition reportable_sales_date_filter %} DECODE(EPS.NHIN_STORE_ID,NULL,DECODE(EPR.RX_TX_REPORTABLE_SALES_DATE,NULL,EPR.RX_TX_FILLED_DATE),EPS.RX_TX_REPORTABLE_SALES_DATE) {% endcondition %}
               AND {% condition filled_date_filter %} DECODE(EPS.NHIN_STORE_ID,NULL,EPR.RX_TX_FILLED_DATE,EPS.RX_TX_FILL_DATE) {% endcondition %}
               THEN 'No'
         ELSE 'Yes' END LAST_YEAR
         FROM EDW.F_RX_TX EPR    -- Encompasses PDX Classic and EPS Non-Symmetric Stores
         INNER JOIN              -- Since this is only Demo, Inner Join is being performed to improve performance.
         ( SELECT
         TX.CHAIN_ID,
         TX.NHIN_STORE_ID,
         TX.RX_TX_ID,
         RX.RX_ID,
         RX.RX_NUMBER,
         TX.RX_TX_TX_NUMBER,
         RX.RX_STATUS,
         TX.RX_TX_TX_STATUS,
         RX.RX_SOURCE,
         RX.RX_ON_FILE,
         RX.RX_TRANSFER_OUT_FILL_COUNT,
         RX.RX_PRESCRIBED_DAYS_SUPPLY,
         RX.RX_MERGED_TO_DATE,
         RX.RX_AUTOFILL_ENABLE_DATE,
         RX.RX_RECEIVED_DATE,
         RX.RX_NCPDP_ROUTE,
         RX.RX_WHOLESALE_ORDER_FLAG,
         RX.RX_CONTROLLED_SUBSTANCE_ESCRIPT_FLAG,
         RX.RX_FILE_BUY_DATE,
         TX.RX_TX_PARTIAL_FILL_STATUS,
         TX.RX_TX_FILL_STATUS,
         TX.RX_TX_POS_STATUS,
         TX.RX_TX_DRUG_DISPENSED,
         DECODE(TX.RX_TX_RETURNED_DATE,NULL,TX.RX_TX_PRICE,NVL(TX.RX_TX_ORIGINAL_PRICE,0)) AS PRICE, --ERXLPS-1351 Search and replace all view files to use EDW materialized columns from RX_TX_LINK
         TX.RX_TX_UC_PRICE,
         DECODE(TX.RX_TX_RETURNED_DATE,NULL,TX.RX_TX_ACQUISITION_COST,0) AS ACQUISITION_COST, --ERXLPS-1351 Search and replace all view files to use EDW materialized columns from RX_TX_LINK
         TX.RX_TX_FILL_QUANTITY,
         TX.RX_TX_REPORTABLE_SALES_DATE,
         TX.RX_TX_RETURNED_DATE,
         --TX.RX_TX_CREDIT_INITIATOR,
         TX.RX_TX_POS_SOLD_DATE,
         TX.RX_TX_WILL_CALL_PICKED_UP_DATE,
         TX.RX_TX_WILL_CALL_ARRIVAL_DATE,
         TX.RX_TX_POS_OVERRIDDEN_NET_PAID,
         TX.RX_TX_DISCOUNT_AMOUNT AS DISCOUNT, --ERXLPS-1351 Search and replace all view files to use EDW materialized columns from RX_TX_LINK
         TX.RX_TX_TAX_AMOUNT,
         TX.RX_TX_TP_BILL,
         TX.RX_TX_REFILL_NUMBER,
         TX.RX_TX_FILL_DATE,
         TX.RX_TX_IS_340B,
         TX.RX_TX_PARTIAL_FILL_BILL_TYPE,
         TX.RX_TX_DELETED,
         RX.RX_DELETED,
         RX.SOURCE_TIMESTAMP AS RX_SOURCE_TIMESTAMP,
         TX.SOURCE_TIMESTAMP AS RX_TX_SOURCE_TIMESTAMP
         FROM EDW.F_RX_TX_LINK TX
         INNER JOIN EDW.F_RX RX
         ON (  RX.CHAIN_ID = TX.CHAIN_ID AND
             RX.NHIN_STORE_ID = TX.NHIN_STORE_ID AND
             RX.RX_ID = TX.RX_ID
           )
         WHERE TX.CHAIN_ID IN (SELECT DISTINCT CHAIN_ID FROM REPORT_TEMP.BI_DEMO_CHAIN_STORE_MAPPING  WHERE {% condition bi_demo_store.bi_demo_nhin_store_id %} NHIN_STORE_ID_BI_DEMO_MAPPING {% endcondition %})   -- Required for performance reasons and to avoid scanning all chain/store records
         AND TX.NHIN_STORE_ID IN (SELECT DISTINCT NHIN_STORE_ID FROM REPORT_TEMP.BI_DEMO_CHAIN_STORE_MAPPING WHERE {% condition bi_demo_store.bi_demo_nhin_store_id %} NHIN_STORE_ID_BI_DEMO_MAPPING {% endcondition %})  -- Required for performance reasons and to avoid scanning all chain/store records
         AND RX.source_system_id = 4
         AND TX.source_system_id = 4
         ) EPS
         ON (  EPR.CHAIN_ID = EPS.CHAIN_ID AND
             EPR.NHIN_STORE_ID = EPS.NHIN_STORE_ID AND
             EPR.RX_TX_RX_NUMBER = EPS.RX_NUMBER AND
             EPR.RX_TX_TX_NUMBER = EPS.RX_TX_TX_NUMBER
           )
         /********************************** START OF SEPARATE CALENDAR DATES ARE REQUIRED FOR SOLD, REPORTABLE_SALES & FILLED DATES *****************************************************/
         /** This would help to ensure, if we are looking for Transactions filled for last 60 Days but only sold in last 30 days, then we don't select transactions sold in last 60 days *****/
         INNER JOIN
         ( SELECT DATEADD(YEAR,-1,MIN(CALENDAR_DATE)) AS MIN_DATE,DATEADD(YEAR,-1,MAX(CALENDAR_DATE)) AS MAX_DATE
             FROM
             ( SELECT TO_DATE(DATEADD(DAY,SEQ4(),TRUNC(TO_DATE(TO_TIMESTAMP('2014-01-01 12:00:00')),'DAY'))) AS CALENDAR_DATE
             FROM TABLE(GENERATOR(rowCount => 5112)) )
             WHERE (
                     {% condition this_year_last_year_filter %} 'Yes-Sold' {% endcondition %}
                     AND {% condition sold_date_filter %} CALENDAR_DATE {% endcondition %}
                   )
         ) LY_SOLD_DATE     -- IMPORTANT VIEW TO DERIVE DATES FOR LAST YEAR WITH REGARD TO SOLD_DATE
         ON 1 = 1
         INNER JOIN
         ( SELECT DATEADD(YEAR,-1,MIN(CALENDAR_DATE)) AS MIN_DATE,DATEADD(YEAR,-1,MAX(CALENDAR_DATE)) AS MAX_DATE
             FROM
             ( SELECT TO_DATE(DATEADD(DAY,SEQ4(),TRUNC(TO_DATE(TO_TIMESTAMP('2014-01-01 12:00:00')),'DAY'))) AS CALENDAR_DATE
             FROM TABLE(GENERATOR(rowCount => 5112)) )
             WHERE (
                     {% condition this_year_last_year_filter %} 'Yes-ReportableSales' {% endcondition %}
                     AND {% condition reportable_sales_date_filter %} CALENDAR_DATE {% endcondition %}
                   )
         ) LY_REPORTABLE_SALES_DATE     -- IMPORTANT VIEW TO DERIVE DATES FOR LAST YEAR WITH REGARD TO REPORTABLE_SALES_DATE
         ON 1 = 1
         INNER JOIN
         ( SELECT DATEADD(YEAR,-1,MIN(CALENDAR_DATE)) AS MIN_DATE,DATEADD(YEAR,-1,MAX(CALENDAR_DATE)) AS MAX_DATE
             FROM
             ( SELECT TO_DATE(DATEADD(DAY,SEQ4(),TRUNC(TO_DATE(TO_TIMESTAMP('2014-01-01 12:00:00')),'DAY'))) AS CALENDAR_DATE
             FROM TABLE(GENERATOR(rowCount => 5112)) )
             WHERE (
                     {% condition this_year_last_year_filter %} 'Yes-Filled' {% endcondition %}
                     AND {% condition filled_date_filter %} CALENDAR_DATE {% endcondition %}
                   )
         ) LY_FILLED_DATE     -- IMPORTANT VIEW TO DERIVE DATES FOR LAST YEAR WITH REGARD TO FILL_DATES
         ON 1 = 1
         /********************************** END OF SEPARATE CALENDAR DATES ARE REQUIRED FOR SOLD, REPORTABLE_SALES & FILLED DATES *****************************************************/
         WHERE EPR.RX_TX_RX_DELETED = 'N'
         AND EPR.RX_TX_TX_DELETED = 'N'
         AND EPR.RX_TX_TX_NUMBER IS NOT NULL
         AND NVL(DECODE(EPS.NHIN_STORE_ID,NULL,EPR.RX_TX_TX_STATUS,EPS.RX_TX_TX_STATUS),'Y') = 'Y'
         AND DECODE(EPS.NHIN_STORE_ID,NULL,EPR.RX_TX_PRICE,EPS.PRICE) IS NOT NULL
         AND DECODE(EPS.NHIN_STORE_ID,NULL,EPR.RX_TX_ACQUISITION_COST,EPS.ACQUISITION_COST) IS NOT NULL
         AND DECODE(EPS.NHIN_STORE_ID,NULL,EPR.RX_TX_FILL_STATUS,EPS.RX_TX_FILL_STATUS) IS NOT NULL
         AND DECODE(EPS.NHIN_STORE_ID,NULL,DECODE(EPR.RX_TX_REPORTABLE_SALES_DATE,NULL,EPR.RX_TX_FILLED_DATE),EPS.RX_TX_REPORTABLE_SALES_DATE) IS NOT NULL
         AND DECODE(EPS.NHIN_STORE_ID,NULL,EPR.RX_TX_FILL_QUANTITY,EPS.RX_TX_FILL_QUANTITY) IS NOT NULL
         AND EPR.CHAIN_ID IN (SELECT DISTINCT CHAIN_ID FROM REPORT_TEMP.BI_DEMO_CHAIN_STORE_MAPPING WHERE {% condition bi_demo_store.bi_demo_nhin_store_id %} NHIN_STORE_ID_BI_DEMO_MAPPING {% endcondition %})   -- Required for performance reasons and to avoid scanning all chain/store records
         AND EPR.NHIN_STORE_ID IN (SELECT DISTINCT NHIN_STORE_ID FROM REPORT_TEMP.BI_DEMO_CHAIN_STORE_MAPPING WHERE {% condition bi_demo_store.bi_demo_nhin_store_id %} NHIN_STORE_ID_BI_DEMO_MAPPING {% endcondition %})  -- Required for performance reasons and to avoid scanning all chain/store records
         AND {% condition cost_filter %} RX_TX_COST {% endcondition %}
         AND {% condition acquisition_cost_filter %} DECODE(EPS.NHIN_STORE_ID,NULL,EPR.RX_TX_ACQUISITION_COST,EPS.ACQUISITION_COST) {% endcondition %}
         AND {% condition autofill_quantity_filter %} RX_TX_AUTOFILL_QUANTITY {% endcondition %}
         AND {% condition fill_quantity_filter %} DECODE(EPS.NHIN_STORE_ID,NULL,EPR.RX_TX_FILL_QUANTITY,EPS.RX_TX_FILL_QUANTITY) {% endcondition %}
         AND {% condition quantity_filter %} RX_TX_QUANTITY {% endcondition %}
         AND {% condition price_filter %} DECODE(EPS.NHIN_STORE_ID,NULL,EPR.RX_TX_PRICE,EPS.PRICE) {% endcondition %}
         AND {% condition gross_margin_filter %} RX_TX_GROSS_MARGIN {% endcondition %}
         AND (
               {% condition sold_date_filter %} DECODE(EPS.NHIN_STORE_ID,NULL,EPR.RX_TX_SOLD_DATE,EPS.RX_TX_WILL_CALL_PICKED_UP_DATE) {% endcondition %}
             OR
               ( {% condition this_year_last_year_filter %} 'Yes-Sold' {% endcondition %}
                 AND DECODE(EPS.NHIN_STORE_ID,NULL,EPR.RX_TX_SOLD_DATE,EPS.RX_TX_WILL_CALL_PICKED_UP_DATE) >= LY_SOLD_DATE.MIN_DATE AND DECODE(EPS.NHIN_STORE_ID,NULL,EPR.RX_TX_SOLD_DATE,EPS.RX_TX_WILL_CALL_PICKED_UP_DATE) < LY_SOLD_DATE.MAX_DATE
               )
             )
         AND (
               {% condition reportable_sales_date_filter %} DECODE(EPS.NHIN_STORE_ID,NULL,DECODE(EPR.RX_TX_REPORTABLE_SALES_DATE,NULL,EPR.RX_TX_FILLED_DATE),EPS.RX_TX_REPORTABLE_SALES_DATE) {% endcondition %}
             OR
               ( {% condition this_year_last_year_filter %} 'Yes-ReportableSales' {% endcondition %}
                 AND DECODE(EPS.NHIN_STORE_ID,NULL,DECODE(EPR.RX_TX_REPORTABLE_SALES_DATE,NULL,EPR.RX_TX_FILLED_DATE),EPS.RX_TX_REPORTABLE_SALES_DATE) >= LY_REPORTABLE_SALES_DATE.MIN_DATE AND DECODE(EPS.NHIN_STORE_ID,NULL,DECODE(EPR.RX_TX_REPORTABLE_SALES_DATE,NULL,EPR.RX_TX_FILLED_DATE),EPS.RX_TX_REPORTABLE_SALES_DATE) < LY_REPORTABLE_SALES_DATE.MAX_DATE
               )
             )
         AND (
               {% condition filled_date_filter %} DECODE(EPS.NHIN_STORE_ID,NULL,EPR.RX_TX_FILLED_DATE,EPS.RX_TX_FILL_DATE) {% endcondition %}
             OR
               ( {% condition this_year_last_year_filter %} 'Yes-Filled' {% endcondition %}
                 AND DECODE(EPS.NHIN_STORE_ID,NULL,EPR.RX_TX_FILLED_DATE,EPS.RX_TX_FILL_DATE) >= LY_FILLED_DATE.MIN_DATE AND DECODE(EPS.NHIN_STORE_ID,NULL,EPR.RX_TX_FILLED_DATE,EPS.RX_TX_FILL_DATE) < LY_FILLED_DATE.MAX_DATE
               )
             )
         AND EXISTS (SELECT NULL
                       FROM EDW.D_PATIENT patient
                      WHERE patient.CHAIN_ID IN (SELECT DISTINCT CHAIN_ID FROM REPORT_TEMP.BI_DEMO_CHAIN_STORE_MAPPING  WHERE {% condition bi_demo_store.bi_demo_nhin_store_id %} NHIN_STORE_ID_BI_DEMO_MAPPING {% endcondition %})
                        AND EPR.CHAIN_ID = patient.CHAIN_ID
                        AND EPR.RX_COM_ID = patient.RX_COM_ID
                        AND patient.PATIENT_SURVIVOR_ID IS NULL
                        AND patient.PATIENT_UNMERGED_DATE IS NULL
                    )
       ;;
    }

    dimension: rx_number {
      label: "Prescription RX Number"
      description: "Prescription number"
      type: number
      sql: ${TABLE}.RX_TX_RX_NUMBER ;;
      value_format: "####"
    }

    dimension: refill_number {
      label: "Prescription Refill Number"
      type: number
      sql: ${TABLE}.RX_TX_REFILL_NUMBER ;;
    }

    dimension: tx_number {
      label: "Prescription TX Number"
      description: "Transaction number"
      type: number
      sql: ${TABLE}.RX_TX_TX_NUMBER ;;
      value_format: "####"
    }

    dimension: unique_key {
      hidden: yes
      primary_key: yes
      type: number
      sql: ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${rx_number} ||'@'|| ${tx_number} ;; #ERXLPS-1649
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

    dimension: rx_com_id {
      hidden: yes
      sql: ${TABLE}.RX_COM_ID ;;
    }

    dimension: rx_tx_id {
      hidden: yes
      # Primary key in source
      sql: ${TABLE}.EPR_RX_TX_ID ;;
    }

    dimension: eps_rx_tx_id {
      hidden: yes
      type: number
      # field used for joining EPS datasets
      sql: ${TABLE}.EPS_RX_TX_ID ;;
    }

    dimension: prescriber_id {
      hidden: yes
      sql: ${TABLE}.PRESCRIBER_ID ;;
    }

    dimension: alternate_prescriber_id {
      hidden: yes
      sql: ${TABLE}.ALTERNATE_PRESCRIBER_ID ;;
    }

    dimension: modpcm_id {
      hidden: yes
      sql: ${TABLE}.RX_TX_MODPCM_ID ;;
    }

    dimension: mrn_id {
      # This column has all values null (as of 15th April 2016)
      hidden: yes
      sql: ${TABLE}.RX_TX_MRN_ID ;;
    }

    ######################################  deleted fields are not exposed to the explore but are used in the join conditions to ensure soft deleted records in application/EDW are not picked up #########################

    dimension: rx_deleted {
      label: "Prescription Deleted"
      hidden: yes
      sql: ${TABLE}.RX_TX_RX_DELETED ;;
    }

    dimension: tx_deleted {
      label: "Prescription TX Deleted"
      hidden: yes
      sql: ${TABLE}.RX_TX_TX_DELETED ;;
    }

    #######################################################################################################################################################################################################################

    ########################################################################################################### Dimensions ################################################################################################

    dimension: ndc {
      hidden: yes
      sql: ${TABLE}.RX_TX_NDC ;;
    }

    dimension: new_rx_number {
      sql: ${TABLE}.RX_TX_NEW_RX_NUMBER ;;
    }

    dimension: old_rx_number {
      sql: ${TABLE}.RX_TX_OLD_RX_NUMBER ;;
    }

    dimension: acs_priority {
      label: "Prescription ACS Priority"
      description: "Numeric rank that indicates the priority of the prescription in the automated counting system.  1 - highest priority, 9 = lowest priority"
      sql: ${TABLE}.RX_TX_ACS_PRIORITY ;;
    }

    dimension: alternate_doctor {
      label: "Prescription Alternate Doctor"
      description: "Mnemonic code representing the alternate prescriber record associated with this transaction"
      sql: ${TABLE}.RX_TX_ALTERNATE_DOCTOR ;;
    }

    dimension: authorized_via_phone {
      label: "Rx Phone - Refill Authorization"
      description: "Indicates if the prescription was approved/authorized via phone by the prescriber"
      sql: ${TABLE}.RX_TX_AUTHORIZED_VIA_PHONE ;;
    }

    #     suggestions: ['Y','N']
    #     full_suggestions: true

    dimension: autofill {
      label: "Prescription Autofill"
      description: "Store autofill setting for this prescription"
      sql: ${TABLE}.RX_TX_AUTOFILL ;;
    }

    dimension: cancel_reason {
      label: "Prescription Cancel Reason"
      description: "Used to store the reason why a this prescription was cancelled"
      sql: ${TABLE}.RX_TX_CANCEL_REASON ;;
    }

    dimension: charge {
      label: "Prescription Accounts Receivable Charge Flag"
      description: "Flag that indicates if the transaction was charged to accounts receivable"
      sql: ${TABLE}.RX_TX_CHARGE ;;
    }

    dimension: check_rx_overwritten {
      label: "Prescription DUR Override Flag"
      description: "Indicates if the pharmacist overrode DUR interaction for the transaction"
      sql: ${TABLE}.RX_TX_CHECK_RX_OVERWRITTEN ;;
    }

    dimension: clinic_reference_number {
      label: "Prescription Clinic Reference Number"
      hidden: yes
      description: "Source the eScript identifier from the souce system"
      sql: ${TABLE}.RX_TX_CLINIC_REFERENCE_NUMBER ;;
    }

    dimension: counseling_choice {
      label: "Prescription Counselling Choice"
      description: "Code that indicates if the patient accepted or rejected counseling information for the transaction. Accepted, Rejected/Refused, Required and Ask"
      sql: ${TABLE}.RX_TX_COUNSELING_CHOICE ;;
    }

    dimension: cpt_code {
      label: "Prescription CPT Code"
      description: "Used to report medical procedures and services under public and private health insurance programs"
      sql: ${TABLE}.RX_TX_CPT_CODE ;;
    }

    dimension: created_via_phone {
      label: "Prescription Phone - New"
      description: "Indicates if a new prescription was initiated via phone by the prescriber"
      sql: ${TABLE}.RX_TX_CREATED_VIA_PHONE ;;
    }

    dimension: cvx_code {
      label: "Prescription CVX Code"
      description: "CDC defined code for the vaccination dispensed"
      sql: ${TABLE}.RX_TX_CVX_CODE ;;
    }

    dimension: days_supply {
      label: "Prescription Days Supply"
      description: "Days supply for this transaction"
      sql: ${TABLE}.RX_TX_DAYS_SUPPLY ;;
    }

    dimension: days_supply_basis {
      label: "Prescription Days Supply Basis"
      description: "Days supply for this transaction"
      sql: ${TABLE}.RX_TX_DAYS_SUPPLY_BASIS ;;
    }

    dimension: days_supply_code {
      label: "Prescription Days Supply Code"
      description: "Basis for which the days supply was calculated.   Not Specified, Explicit Directions, PRN Directions and As Directed By Prescriber"
      sql: ${TABLE}.RX_TX_DAYS_SUPPLY_CODE ;;
    }

    dimension: doctor_daw {
      label: "Prescription Doctor DAW"
      description: "DAW associated to the prescriber of this prescription"
      sql: ${TABLE}.RX_TX_DOCTOR_DAW ;;
    }

    dimension: dose_cover {
      label: "Prescription Dose Cover"
      description: "Indicates if a dose check override was performed during the filling process"
      sql: ${TABLE}.RX_TX_DOSE_COVER ;;
    }

    dimension: drug_code {
      label: "Prescription Drug Code"
      description: "Represents the drug code for the drug used on this prescription transaction"
      sql: ${TABLE}.RX_TX_DRUG_CODE ;;
    }

    dimension: drug_schedule {
      hidden: yes
      sql: ${TABLE}.RX_TX_DRUG_SCHEDULE ;;
    }

    dimension: duplicate_therapy {
      label: "Prescription Duplicate Therapy"
      description: "Indicates if a duplicate therapy override was performed during the filling process"
      sql: ${TABLE}.RX_TX_DUPLICATE_THERAPY ;;
    }

    dimension: dur_override {
      label: "Prescription DUR Override"
      description: "Indicates if a DUR override was performed during the filling process"
      sql: ${TABLE}.RX_TX_DUR_OVERRIDE ;;
    }

    dimension: fill_status {
      label: "Prescription Fill Status"
      description: "Indicates the type of transaction. New prescription transaction, Refill transaction and Non-filled, Cognitive service transaction"
      sql: ${TABLE}.RX_TX_FILL_STATUS ;;
    }

    dimension: force_cog {
      label: "Prescription Force Cog"
      sql: ${TABLE}.RX_TX_FORCE_COG ;;
    }

    dimension: group_code {
      label: "Prescription Group Code"
      description: "Group code for this prescription"
      sql: ${TABLE}.RX_TX_GROUP_CODE ;;
    }

    dimension: icd9_code {
      label: "Prescription ICD9 Code"
      sql: ${TABLE}.RX_TX_ICD9_CODE ;;
    }

    dimension: icd9_type {
      label: "Prescription ICD9 Type"
      sql: ${TABLE}.RX_TX_ICD9_TYPE ;;
    }

    dimension: immunization_indicator {
      label: "Prescription Immunization Indicator"
      description: "Stores the indicator which denotes a prescription was a vaccine"
      sql: ${TABLE}.RX_TX_IMMUNIZATION_INDICATOR ;;
    }

    dimension: initials {
      label: "Prescription Initials"
      sql: ${TABLE}.RX_TX_INITIALS ;;
    }

    dimension: interaction_code {
      label: "Prescription Interaction Code"
      sql: ${TABLE}.RX_TX_INTERACTION_CODE ;;
    }

    dimension: interaction_override {
      label: "Prescription Interaction Override Flag"
      description: "Flag indicating if an interaction override was performed during the filling process"
      sql: ${TABLE}.RX_TX_INTERACTION_OVERRIDE ;;
    }

    dimension: interaction_rx_source {
      label: "Prescription Interaction Rx Source"
      description: "Used to indicate the source of an Interaction prescription. Outside Pharmacy, Sample, Back Office, Historical Med, Internal Reference, External Reference, Module and Nurse Treatment Room"
      sql: ${TABLE}.RX_TX_INTERACTION_RX_SOURCE ;;
    }

    dimension: manufacturer {
      label: "Prescription Manufacturer"
      description: "Manufacturer name"
      sql: ${TABLE}.RX_TX_MANUFACTURER ;;
    }

    dimension: mvx_code {
      label: "Prescription MVX Code"
      description: "Stores the manufacturer code for the vaccine administered"
      sql: ${TABLE}.RX_TX_MVX_CODE ;;
    }

    dimension: ncpdp_daw {
      label: "Prescription NCPDP DAW"
      description: "Third party dispensed as written flag that indicates which DAW code was assigned during data entry"
      case: {
        when: {
          sql: ${TABLE}.RX_TX_NCPDP_DAW = '0' ;;
          label: "0 - NO SELECTION"
        }

        when: {
          sql: ${TABLE}.RX_TX_NCPDP_DAW = '1' ;;
          label: "1 - DISPENSE AS WRITTEN"
        }

        when: {
          sql: ${TABLE}.RX_TX_NCPDP_DAW = '2' ;;
          label: "2 - BRAND - PATIENT CHOICE"
        }

        when: {
          sql: ${TABLE}.RX_TX_NCPDP_DAW = '3' ;;
          label: "3 - BRAND - PHARMACIST CHOICE"
        }

        when: {
          sql: ${TABLE}.RX_TX_NCPDP_DAW = '4' ;;
          label: "4 - BRAND - GENERIC OUT OF STOCK"
        }

        when: {
          sql: ${TABLE}.RX_TX_NCPDP_DAW = '5' ;;
          label: "5 - BRAND - DISPENSED AS GENERIC"
        }

        when: {
          sql: ${TABLE}.RX_TX_NCPDP_DAW = '6' ;;
          label: "6 - OVERRIDE"
        }

        when: {
          sql: ${TABLE}.RX_TX_NCPDP_DAW = '7' ;;
          label: "7 - BRAND - MANDATED BY LAW"
        }

        when: {
          sql: ${TABLE}.RX_TX_NCPDP_DAW = '8' ;;
          label: "8 - BRAND - GENERIC UNAVAILABLE"
        }

        when: {
          sql: ${TABLE}.RX_TX_NCPDP_DAW = '9' ;;
          label: "9 - OTHER"
        }

        when: {
          sql: ${TABLE}.RX_TX_NCPDP_DAW IS NULL ;;
          label: "NOT SPECIFIED"
        }
      }
      suggestions: [
        "0 - NO SELECTION",
        "1 - DISPENSE AS WRITTEN",
        "2 - BRAND - PATIENT CHOICE",
        "3 - BRAND - PHARMACIST CHOICE",
        "4 - BRAND - GENERIC OUT OF STOCK",
        "5 - BRAND - DISPENSED AS GENERIC",
        "6 - OVERRIDE",
        "7 - BRAND - MANDATED BY LAW",
        "8 - BRAND - GENERIC UNAVAILABLE",
        "9 - OTHER",
        "NOT SPECIFIED"
      ]
    }

    dimension: not_picked_up_yet {
      label: "Prescription Not Picked Up Yet"
      description: "Indicates if prescription has been picked up"
      sql: ${TABLE}.RX_TX_NOT_PICKED_UP_YET ;;
    }

    dimension: nsc_choice {
      label: "Rx No Safety Caps Flag"
      description: "Y/N Flag indicating NSC Choice will store whether the patient opted out of safety caps for this fill"
      sql: ${TABLE}.RX_TX_NSC_CHOICE ;;
    }

    dimension: number_of_labels {
      label: "Prescription Number Of Labels"
      description: "Stores the number of labels printed for this prescription fill"
      sql: ${TABLE}.RX_TX_NUMBER_OF_LABELS ;;
    }

    dimension: order_initials {
      sql: ${TABLE}.RX_TX_ORDER_INITIALS ;;
    }

    dimension: other_nhin_store_id {
      label: "Prescription Other NHIN Store ID"
      description: "Stores the NHIN ID of the pharmacy that has custody of a prescription. This is the pharmacy from which the prescription would have to be transferred to be filled at any other pharmacy"
      sql: ${TABLE}.RX_TX_OTHER_NHIN_STORE_ID ;;
    }

    dimension: pac_med {
      label: "Prescription PAC Med"
      description: "Flag that indicates whether the prescription was filled with a PacMed system"
      sql: ${TABLE}.RX_TX_PAC_MED ;;
    }

    dimension: physician_code {
      label: "Prescription Physician Code"
      description: "Stores the PDX Retail formatted prescriber code. This column has all values null as of 15th April 2016"
      sql: ${TABLE}.RX_TX_PHYSICIAN_CODE ;;
    }

    dimension: pos_type {
      label: "Prescription POS Type"
      description: "Type of POS being used by Classic (manual or POS)"
      sql: ${TABLE}.RX_TX_POS_TYPE ;;
    }

    dimension: price_code {
      label: "Prescription Price Code"
      description: "Price code used to price this prescription"
      sql: ${TABLE}.RX_TX_PRICE_CODE ;;
    }

    dimension: pv_initials {
      label: "Prescription PV Initials"
      description: "Initials of the user who performed Product Verification on this transaction"
      sql: ${TABLE}.RX_TX_PV_INITIALS ;;
    }

    dimension: rph_counselling_initials {
      label: "Prescription Rph Counselling Initials"
      description: "Stores the initials of user that counseled the patient"
      sql: ${TABLE}.RX_TX_RPH_COUNSELLING_INITIALS ;;
    }

    dimension: tech_initials {
      label: "Prescription Tech Initials"
      sql: ${TABLE}.RX_TX_TECH_INITIALS ;;
    }

    dimension: tax_code {
      label: "Prescription Tax Code"
      description: "Tax Code used to price this prescription, if applicable"
      sql: ${TABLE}.RX_TX_TAX_CODE ;;
    }

    dimension: via_prefill {
      label: "Prescription Via Prefill"
      description: "Indicates if the fill of this prescription was due to a pre-fill"
      sql: ${TABLE}.RX_TX_VIA_PREFILL ;;
    }

    dimension: why_deactivated_reason {
      label: "Prescription Why Deactivated Reason"
      description: "Stores the deactivation reason for a prescription"
      sql: ${TABLE}.RX_TX_WHY_DEACTIVATED ;;
    }

    dimension: will_call_ready_flag {
      label: "Prescription Will Call Ready Flag"
      description: "Flag indicating if this prescription is ready to be placed into Will Call"
      sql: ${TABLE}.RX_TX_WILL_CALL_READY ;;
    }

    dimension: store_dispensed_drug_gpi {
      hidden: yes
      sql: ${TABLE}.RX_TX_DISPENSED_DRUG_GPI ;;
    }

    dimension: store_dispensed_drug_ndc {
      hidden: yes
      sql: ${TABLE}.RX_TX_DISPENSED_DRUG_NDC ;;
    }

    # dimension name changed during code review of ERXLPS-121
    dimension: days_since_last_activity_patient {
      label: "Days Since Patient's Last Activity"
      description: "Indicates the number of days since the patient had his prescription last filled"
      type: number
      sql: ${TABLE}.DAYS_SINCE_LAST_ACTIVITY ;;
    }

    dimension: rx_tx_refills_remaining {
      type: string
      label: "Prescription Transaction Refills Remaining"
      description: "Refills remaining for this prescription"
      sql: ${TABLE}.RX_TX_REFILLS_REMAINING ;;
    }

    ############################################################################################ US47412  #########################################################################################

    dimension: rx_tx_order_class {
      label: "Prescription Order Class"
      description: "Field that indicates the class of the order. The order class is used to indicate the priority of the Prescription"
      type: string
      sql: ${TABLE}.RX_TX_ORDER_CLASS ;;
    }

    dimension: rx_tx_order_type {
      label: "Prescription Order Type"
      description: "Field that identifies the type of order the Prescription is for"
      type: string
      sql: ${TABLE}.RX_TX_ORDER_TYPE ;;
    }

    dimension: rx_tx_program_add {
      label: "Prescription Program Add"
      description: "Program Add"
      type: string
      sql: ${TABLE}.RX_TX_PROGRAM_ADD ;;
    }

    dimension: rx_tx_specialty {
      label: "Prescription Speciality"
      description: "Flag that indicates whether a prescription was filled for a specialty drug"
      type: string
      sql: ${TABLE}.RX_TX_SPECIALTY ;;
    }

    dimension: rx_tx_route_of_administration {
      label: "Prescription Route of Administration"
      description: "Stores the code for reporting the route of administration to immunization registries"
      type: string
      sql: ${TABLE}.RX_TX_ROUTE_OF_ADMINISTRATION ;;
    }

    dimension: rx_tx_site_of_administration {
      label: "Prescription Site of Adminstration"
      description: "Stores the code for reporting the site of administration to immunization registries"
      type: string
      sql: ${TABLE}.RX_TX_SITE_OF_ADMINISTRATION ;;
    }

    dimension: rx_tx_print_drug_name {
      label: "Prescription Print Drug Name"
      description: "Prescription Print Drug Name"
      type: number
      sql: ${TABLE}.RX_TX_PRINT_DRUG_NAME ;;
    }

    dimension: audit_access_log_id {
      hidden: yes
      label: "Prescription Access Log Id"
      description: "Audit Access Log Identifier"
      type: number
      sql: ${TABLE}.AUDIT_ACCESS_LOG_ID ;;
    }

    ################################################################## Dimensions ( These column has all values null (as of 15th April 2016) ###########################################################

    dimension: benefits_rights_letter {
      #       This column has all values null (as of 15th April 2016)
      hidden: yes
      label: "Prescription Benefits Rights Letter"
      description: "Indicates if patient has received Benefits Rights Letter"
      sql: ${TABLE}.RX_TX_BENEFITS_RIGHTS_LETTER ;;
    }

    dimension: confidentiality_ind {
      #       This column has all values null (as of 15th April 2016)
      hidden: yes
      label: "Prescription Confidentiality Ind"
      description: "Flag used to indicate if the prescription is to be kept confidential from the patient's parent or guardian"
      sql: ${TABLE}.RX_TX_CONFIDENTIALITY_IND ;;
    }

    dimension: counsel_reason {
      #       This column has all values null (as of 15th April 2016)
      hidden: yes
      label: "Prescription Counsel Reason"
      sql: ${TABLE}.RX_TX_COUNSEL_REASON ;;
    }

    dimension: deact_rx_user_emp_num {
      #       This column has all values null (as of 15th April 2016)
      hidden: yes
      label: "Prescription Deact Rx User Emp Num"
      description: "Employee number of user who deactivated this prescription"
      sql: ${TABLE}.RX_TX_DEACT_RX_USER_EMP_NUM ;;
    }

    dimension: deact_rx_user_first_name {
      #       This column has all values null (as of 15th April 2016)
      hidden: yes
      label: "Prescription Deact Rx User First Name"
      description: "First name of user who deactivated this prescription"
      sql: ${TABLE}.RX_TX_DEACT_RX_USER_FIRST_NAME ;;
    }

    dimension: deact_rx_user_last_name {
      #       This column has all values null (as of 15th April 2016)
      hidden: yes
      label: "Prescription Deact Rx User Last Name"
      description: "Last name of user who deactivated this prescription"
      sql: ${TABLE}.RX_TX_DEACT_RX_USER_LAST_NAME ;;
    }

    dimension: drug_image_key {
      #       This column has all values null (as of 15th April 2016)
      hidden: yes
      label: "Prescription Drug Image Key"
      description: "DIB filename of the drug image associated with this transaction"
      sql: ${TABLE}.RX_TX_DRUG_IMAGE_KEY ;;
    }

    dimension: enterprise_rx_fill_count {
      #       This column has all values null (as of 15th April 2016)
      hidden: yes
      sql: ${TABLE}.RX_TX_ENTERPRISE_RX_FILL_COUNT ;;
    }

    dimension: lang_manually_selected {
      #       This column has all values null (as of 15th April 2016)
      hidden: yes
      label: "Prescription Lang Manually Selected"
      description: "Indicates if a language (that is not the default for this patient) was manually selected by a user during the fill of this prescription"
      sql: ${TABLE}.RX_TX_LANG_MANUALLY_SELECTED ;;
    }

    dimension: last_message_source {
      #       This column has all values null (as of 15th April 2016)
      hidden: yes
      label: "Prescription Last Message Source"
      sql: ${TABLE}.RX_TX_LAST_MESSAGE_SOURCE ;;
    }

    dimension: local_mail {
      #       This column has all values null (as of 15th April 2016)
      hidden: yes
      label: "Prescription Local Mail"
      description: "Indicates if this prescription was processed via Local Mail EPS"
      sql: ${TABLE}.RX_TX_LOCAL_MAIL ;;
    }

    dimension: lost {
      #       This column has all values null (as of 15th April 2016)
      hidden: yes
      label: "Prescription Lost"
      description: "Used to indicate if this prescription transaction record was flagged as lost"
      sql: ${TABLE}.RX_TX_LOST ;;
    }

    dimension: mrn_location_code {
      #       This column has all values null (as of 15th April 2016)
      hidden: yes
      sql: ${TABLE}.RX_TX_MRN_LOCATION_CODE ;;
    }

    dimension: prescriber_order_number {
      #       This column has all values null (as of 15th April 2016)
      hidden: yes
      sql: ${TABLE}.RX_TX_PRESCRIBER_ORDER_NUMBER ;;
    }

    dimension: renewed_rx {
      #       This column has all values null (as of 15th April 2016)
      hidden: yes
      label: "Prescription Renewed"
      description: "Indicates if this prescription was renewed"
      sql: ${TABLE}.RX_TX_RENEWED_RX ;;
    }

    dimension: rx_note {
      #       This column has all values null (as of 15th April 2016)/safe-harbor
      hidden: yes
      sql: ${TABLE}.RX_TX_RX_NOTE ;;
    }

    dimension: rx_serial_number {
      #       This column has all values null (as of 15th April 2016)/safe-harbor
      hidden: yes
      sql: ${TABLE}.RX_TX_RX_SERIAL_NUMBER ;;
    }

    dimension: rxfill_indicator {
      #       This column has all values null (as of 15th April 2016)
      hidden: yes
      label: "Prescription Fill Indicator"
      description: "Stores the indication given by the prescriber to receive prescription filling alerts"
      sql: ${TABLE}.RX_TX_RXFILL_INDICATOR ;;
    }

    dimension: sending_application {
      #       This column has all values null (as of 15th April 2016)
      hidden: yes
      label: "Prescription Sending Application"
      description: "Used to identify the application from which the escript prescription originated"
      sql: ${TABLE}.RX_TX_SENDING_APPLICATION ;;
    }

    dimension: shipper_tracking_number {
      #       This column has all values null (as of 15th April 2016)/safe-harbor
      hidden: yes
      sql: ${TABLE}.RX_TX_SHIPPER_TRACKING_NUMBER ;;
    }

    dimension: therapeutic_conversion {
      #       This column has all values null (as of 15th April 2016)
      hidden: yes
      label: "Prescription Therapeutic Conversion"
      description: "Indicates if the prescription was generated due to a therapeutic conversaion"
      sql: ${TABLE}.RX_TX_THERAPEUTIC_CONVERSION ;;
    }

    dimension: unverified_rx {
      #       This column has all values null (as of 15th April 2016)
      hidden: yes
      label: "Prescription Unverified Rx"
      description: "Flag that indicates whether a prescription is an unverified prescription and was posted to the patient?s profile without being verified by a pharmacist"
      sql: ${TABLE}.RX_TX_UNVERIFIED_RX ;;
    }

    dimension: workers_comp_flag {
      #       This column has all values null (as of 15th April 2016)
      hidden: yes
      label: "Prescription Workers Comp Flag"
      description: "Indicates if the prescription is filed under Workers Compensation"
      sql: ${TABLE}.RX_TX_WORKERS_COMP ;;
    }

    dimension: tx_message {
      sql: ${TABLE}.RX_TX_TX_MESSAGE ;;
    }

    dimension: tx_note {
      #       This column has all values null (as of 15th April 2016)/safe-harbor
      hidden: yes
      sql: ${TABLE}.RX_TX_TX_NOTE ;;
    }

    ########################################################################################################### DATE/TIME specific Fields ################################################################################
    dimension_group: archive {
      label: "Prescription Archive"
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
      sql: ${TABLE}.RX_TX_ARCHIVE_DATE ;;
    }

    dimension: deactivate_rx_date {
      #       This column has all values null (as of 15th April 2016)
      hidden: yes
      label: "Prescription Deactivate Rx Date"
      description: ""
      sql: ${TABLE}.RX_TX_DEACTIVATE_RX_DATE ;;
    }

    dimension: drug_expiration_date {
      label: "Prescription Drug Expiration Date"
      description: "Represents the drug expiration date of the drug filled for this prescription transaction"
      sql: ${TABLE}.RX_TX_DRUG_EXPIRATION_DATE ;;
    }

    dimension: expiration_date {
      label: "Prescription Expiration Date"
      description: "Stores the expiration date of prescription"
      sql: ${TABLE}.RX_TX_EXPIRATION_DATE ;;
    }

    dimension: host_retrieval_date {
      label: "Prescription Host Retrieval Date"
      sql: ${TABLE}.RX_TX_HOST_RETRIEVAL_DATE ;;
    }

    dimension_group: filled {
      label: "Prescription Filled"
      description: "Date prescription was filled"
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
      #     can_filter: false
      sql: CASE WHEN ${TABLE}.LAST_YEAR = 'Yes' THEN DATEADD(YEAR,1,${TABLE}.RX_TX_FILLED_DATE) ELSE ${TABLE}.RX_TX_FILLED_DATE END ;;
    }

    dimension_group: first_filled {
      label: "Prescription First Filled"
      description: "Stores the date of the original prescription fill"
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
      sql: ${TABLE}.RX_TX_FIRST_FILLED_DATE ;;
    }

    dimension_group: follow_up_date {
      label: "Prescription Follow Up Date"
      description: "Stores the Follow-up date"
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
      sql: ${TABLE}.RX_TX_FOLLOW_UP_DATE ;;
    }

    dimension_group: original_written {
      label: "Prescription Original Written"
      description: "Original written date of the first prescription in a series of reassigned prescriptions"
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
      sql: ${TABLE}.RX_TX_ORIGINAL_WRITTEN_DATE ;;
    }

    dimension_group: reportable_sales_date {
      label: "Prescription Reportable Sales"
      description: "Used to record the date when a TP script was adjudicated. For cash scripts, it is set when DE is completed"
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
      sql: CASE WHEN ${TABLE}.LAST_YEAR = 'Yes' THEN DATEADD(YEAR,1,${TABLE}.RX_TX_REPORTABLE_SALES_DATE) ELSE ${TABLE}.RX_TX_REPORTABLE_SALES_DATE END ;;
    }

    dimension_group: returned_date {
      label: "Prescription Returned"
      description: "Date/Time Credit Return on the transaction is performed"
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
      sql: ${TABLE}.RX_TX_RETURNED_DATE ;;
    }

    dimension_group: rx_start {
      label: "Prescription Start"
      description: "Effective or the Earliest Fill Date/Time in which the pharmacy may fill a prescription"
      sql: ${TABLE}.RX_TX_RX_START_DATE ;;
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
    }

    dimension_group: sched_drug_report {
      label: "Prescription Sched Drug Report"
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
      sql: ${TABLE}.RX_TX_SCHED_DRUG_REPORT_DATE ;;
    }

    dimension_group: sold {
      label: "Prescription Sold"
      description: "Date/Time prescription was sold"
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
      sql: CASE WHEN ${TABLE}.LAST_YEAR = 'Yes' THEN DATEADD(YEAR,1,${TABLE}.RX_TX_SOLD_DATE) ELSE ${TABLE}.RX_TX_SOLD_DATE END ;;
    }

    dimension_group: written {
      label: "Prescription Written"
      description: "Date/Time prescription was written"
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
      sql: ${TABLE}.RX_TX_WRITTEN_DATE ;;
    }

    dimension_group: will_call_picked_up {
      label: "Will Call Picked Up"
      description: "Date/Time that a prescription was sold out of Will Call by a User or a POS system"
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
      sql: ${TABLE}.RX_TX_WILL_CALL_PICKED_UP_DATE ;;
    }

    dimension: fill_time {
      description: "Time taken to fill a prescription transaction. Calculation Used: SOLD_DATE - FILLED_DATE"
      type: number
      sql: DATEDIFF(MIN,${filled_date},${sold_date}) ;;
    }

    ##################################################################################### YES/NO & CASE WHEN fields ###############################################################################################

    dimension: paid_at_uc {
      label: "Prescription Paid At U&C Price"
      description: "Yes/No flag indicating if the transaction was paid in a U&C pricing of the drug filled"
      type: yesno
      sql: ${TABLE}.RX_TX_UC_PRICE = ${TABLE}.RX_TX_PRICE ;;
    }

    dimension: allergy_override {
      label: "Prescription Allergy Overide Flag"
      description: "Yes/No Flag indicating if an allergy override was performed during the filling process"
      type: yesno
      sql: ${TABLE}.RX_TX_ALLERGY_OVERRIDE = '*' ;;
    }

    dimension: compound {
      label: "Prescription Compound Flag"
      description: "Y/N Flag that determines whether prescription is for a compound drug"
      sql: ${TABLE}.RX_TX_COMPOUND ;;
    }

    dimension: has_compound_ingredients {
      label: "Prescription Has Compound Ingredients"
      description: "Indicates if this prescription is for a compound, and therefore has an associated Compound Ingredients transaction record"
      sql: ${TABLE}.RX_TX_HAS_COMPOUND_INGREDIENTS ;;
    }

    dimension: has_tx_creds {
      label: "Prescription Has Tx Creds Flag"
      description: "Yes/No flag indicating if a given prescription transaction has been credited"
      type: yesno
      sql: ${TABLE}.RX_TX_HAS_TX_CREDS = 'Y' ;;
    }

    dimension: has_tx_tps {
      label: "Prescription Has Tx Tps Flag"
      description: "Yes/No flag indicating if a given prescription transaction has claims"
      type: yesno
      sql: ${TABLE}.RX_TX_HAS_TX_TPS = 'Y' ;;
    }

    dimension: usual_and_customary_pricing_flag {
      label: "Prescription Usual And Customary Pricing Flag"
      description: "Yes/No Flag that indicates if this transaction used usual and customary pricing"
      type: yesno
      sql: ${TABLE}.RX_TX_USUAL = 'Y' ;;
    }

    dimension: autofill_mail {
      label: "Prescription Autofill Mail"
      description: "SBMO autofill setting for this prescription"

      case: {
        when: {
          sql: ${TABLE}.RX_TX_AUTOFILL_MAIL = 'Y' ;;
          label: "Automail"
        }

        when: {
          sql: ${TABLE}.RX_TX_AUTOFILL_MAIL = 'N' ;;
          label: "AutoFill/Ask"
        }

        when: {
          sql: ${TABLE}.RX_TX_AUTOFILL_MAIL = 'R' ;;
          label: "Refused"
        }

        when: {
          sql: true ;;
          label: "None of the Above"
        }
      }
    }

    dimension: call_for_refills {
      label: "Prescription Call For Refills"
      description: "Flag that determines what AutoFill should do when no refills remain or the prescription has expired"

      case: {
        when: {
          sql: ${TABLE}.RX_TX_CANCEL_REASON = 'D' ;;
          label: "Call Prescriber"
        }

        when: {
          sql: ${TABLE}.RX_TX_CANCEL_REASON = 'P' ;;
          label: "Notify Patient"
        }

        when: {
          sql: ${TABLE}.RX_TX_CANCEL_REASON = 'N' ;;
          label: "Do Not Autofill"
        }

        # ERXLPS-200  Changes made based on code review and discussion with QA and referring to Data Dictionary(Lexicon)
        when: {
          sql: true ;;
          label: "No Preference Selected"
        }
      }
    }

    dimension: immunization_indicator_description {
      label: "Prescription Immunization Indicator Description"
      description: "Immunization Vs. Non-Immunization Prescriptions"

      case: {
        when: {
          sql: ${TABLE}.RX_TX_IMMUNIZATION_INDICATOR = 'Y' ;;
          label: "Immunization"
        }

        when: {
          sql: true ;;
          label: "Non-Immunization"
        }
      }
    }

    dimension: partial_fill_status {
      label: "Prescription Partial Fill Status"
      description: "Stores the indicator of 'P' or 'C' for partial(P) /completion(C) fills"
      sql: ${TABLE}.RX_TX_PARTIAL_FILL_STATUS ;;
    }

    dimension: rx_status {
      label: "Prescription Status"
      description: "Represents the current status of the prescription in the pharmacy"

      case: {
        when: {
          sql: ${TABLE}.RX_TX_RX_STATUS = 'U' ;;
          label: "Unit Dose"
        }

        #[ERXLPS-6155]
        when: {
          sql: ${TABLE}.RX_TX_RX_STATUS = 'Y' ;;
          label: "Fillable(EPS)/Active(PDX)"
        }

        when: {
          sql: ${TABLE}.RX_TX_RX_STATUS = 'H' ;;
          label: "On File / Hold"
        }

        when: {
          sql: ${TABLE}.RX_TX_RX_STATUS = 'I' ;;
          label: "Interaction DUR"
        }

        when: {
          sql: ${TABLE}.RX_TX_RX_STATUS = 'R' ;;
          label: "Reassigned"
        }

        when: {
          sql: ${TABLE}.RX_TX_RX_STATUS = 'C' ;;
          label: "Credited Rx"
        }

        when: {
          sql: ${TABLE}.RX_TX_RX_STATUS = 'S' ;;
          label: "Service Rx"
        }

        when: {
          sql: ${TABLE}.RX_TX_RX_STATUS = 'E' ;;
          label: "Temp Workflow Rx (DUR)"
        }

        when: {
          sql: ${TABLE}.RX_TX_RX_STATUS = 'N' ;;
          label: "Non Fillable (EPS Only)"
        }

        when: {
          sql: ${TABLE}.RX_TX_RX_STATUS = 'D' ;;
          label: "Deactivated (PDX Only)"
        }

        when: {
          sql: true ;;
          label: "Unknown"
        }
      }
    }

    dimension: tp_bill_flag {
      label: "Prescription Tp Bill Flag"
      description: "Indicates if this transaction was a Cash or 'T/P'"

      case: {
        when: {
          sql: NVL(${TABLE}.RX_TX_TP_BILL,'N') = 'N' ;;
          label: "Cash"
        }

        else: "T/P"
      }
    }

    dimension: tp_bill_status {
      label: "Prescription Tp Bill Status"
      description: "Indicates if this transaction was charged to a third party"

      case: {
        when: {
          sql: ${TABLE}.RX_TX_TP_BILL = 'Y' ;;
          label: "Charged"
        }

        when: {
          sql: ${TABLE}.RX_TX_TP_BILL = 'T' ;;
          label: "Transmitted"
        }

        when: {
          sql: NVL(${TABLE}.RX_TX_TP_BILL,'N') = 'N' ;;
          label: "Not Charged"
        }
      }
    }

    dimension: transfer {
      label: "Prescription Transfer"
      description: "Flag indicating whether the prescription has been transfer, either incoming or outgoing"

      case: {
        when: {
          sql: ${TABLE}.RX_TX_TRANSFER = 'I' ;;
          label: "Incoming"
        }

        when: {
          sql: ${TABLE}.RX_TX_TRANSFER IN ('O','A') ;;
          label: "Outgoing"
        }

        else: "Non-Transfers"
      }
    }

    dimension: tx_status {
      label: "Prescription TX Status"
      description: "Flag indicating the status (Active, Cancelled, Credit Returned, Hold & Replacement) of the transaction"

      case: {
        when: {
          sql: NVL(${TABLE}.RX_TX_TX_STATUS,'Y') = 'Y' AND ${TABLE}.RX_TX_RX_STATUS NOT IN ('N','H','C','D') AND ${TABLE}.RX_TX_RX_STATUS IS NOT NULL AND ${TABLE}.RX_TX_COST IS NOT NULL AND ${TABLE}.RX_TX_PRICE IS NOT NULL ;;
          label: "Active"
        }

        when: {
          sql: ${TABLE}.RX_TX_TX_STATUS = 'N' ;;
          label: "Cancelled"
        }

        when: {
          sql: ${TABLE}.RX_TX_TX_STATUS = 'C' ;;
          label: "Credit Returned"
        }

        when: {
          sql: ${TABLE}.RX_TX_TX_STATUS = 'H' ;;
          label: "Hold"
        }

        else: "Replacement"
      }
    }

    dimension: active_or_nonactive_fills {
      description: "Flag indicating if you want active/non-active fills or every other prescription thats not deleted."
      # as this is used only as  filter
      hidden: yes
      sql: ${TABLE}.ACTIVE_OR_NON_ACTIVE ;;
      suggestions: ["Active"]
    }

    ################################################################################################ EPS Specific Only Fields #############################################################################

    dimension_group: pos_sold {
      label: "Prescription POS Sold"
      description: "Date/Time the transaction was sold from the POS system. It is set upon the receipt of a POSSoldRequest from the POS system. This field is EPS only!!!"
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
      sql: ${TABLE}.RX_TX_POS_SOLD_DATE ;;
    }

    dimension_group: rx_merged {
      label: "Prescription Merged"
      description: "Date/Time on which the patient was changed on this prescription due to a single-Rx merge. This field is EPS only!!!"
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
      sql: ${TABLE}.RX_MERGED_TO_DATE ;;
    }

    dimension_group: autofill_enabled {
      label: "Prescription Autofill Enabled"
      description: "Date/Time the prescription was set up for auto-fill. This field is EPS only!!!"
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
      sql: ${TABLE}.RX_AUTOFILL_ENABLE_DATE ;;
    }

    dimension_group: rx_file_buy {
      label: "Prescription File Buy"
      description: "Date/Time that identifies if a patient or script was imported into EPS as part of a file buy. Is populated with the date the patient or script was imported into the system. This field is EPS only!!!"
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
      sql: ${TABLE}.RX_FILE_BUY_DATE ;;
    }

    dimension_group: rx_received {
      label: "Prescription Received"
      description: "Date/Time that a prescription was presented to the pharmacy for filling. Set either by the user upon receipt of the Rx (or) when a new escript Rx is received in the store (or) populated by the auto transfer response with the received date sent in the auto transfer message. This field is EPS only!!!"
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
      sql: ${TABLE}.RX_RECEIVED_DATE ;;
    }

    dimension_group: will_call_arrival {
      label: "Prescription Will Call Arrival"
      description: "Date/time that a prescription enters Will Call. This field is EPS only!!!"
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
      sql: ${TABLE}.RX_TX_WILL_CALL_ARRIVAL_DATE ;;
    }

    dimension: pos_status {
      label: "Prescription POS Status"
      description: "Status of the transaction with respect to the POS system. This field is EPS only!!!"
      type: string

      case: {
        when: {
          sql: ${TABLE}.RX_TX_POS_STATUS = 'S' ;;
          label: "Sent"
        }

        when: {
          sql: ${TABLE}.RX_TX_POS_STATUS = 'R' ;;
          label: "Replace When Sent"
        }

        when: {
          sql: ${TABLE}.RX_TX_POS_STATUS = 'D' ;;
          label: "To Be Deleted"
        }

        when: {
          sql: ${TABLE}.RX_TX_POS_STATUS = 'A' ;;
          label: "Already On POS"
        }

        when: {
          sql: true ;;
          label: "Not Sent"
        }
      }
    }

    dimension: rx_source {
      label: "Prescription Source"
      description: "Indicates what process was used to create this prescription record. This field is EPS only!!!"
      type: string

      case: {
        when: {
          sql: ${TABLE}.RX_SOURCE = 0 ;;
          label: "Not Specified"
        }

        when: {
          sql: ${TABLE}.RX_SOURCE = 1 ;;
          label: "Written"
        }

        when: {
          sql: ${TABLE}.RX_SOURCE = 2 ;;
          label: "Phoned In"
        }

        when: {
          sql: ${TABLE}.RX_SOURCE = 3 ;;
          label: "E-Script"
        }

        when: {
          sql: ${TABLE}.RX_SOURCE = 4 ;;
          label: "Fax"
        }

        when: {
          sql: ${TABLE}.RX_SOURCE = 5 ;;
          label: "Pharmacy Generated"
        }

        when: {
          sql: ${TABLE}.RX_SOURCE = 20 ;;
          label: "Manual Transfer"
        }

        when: {
          sql: ${TABLE}.RX_SOURCE = 21 ;;
          label: "Informational Rx"
        }

        when: {
          sql: ${TABLE}.RX_SOURCE = 22 ;;
          label: "Patient Specified"
        }

        when: {
          sql: ${TABLE}.RX_SOURCE = 23 ;;
          label: "Auto Transfer"
        }

        when: {
          sql: ${TABLE}.RX_SOURCE = 24 ;;
          label: "Transfer Auto RAR"
        }

        when: {
          sql: ${TABLE}.RX_SOURCE = 25 ;;
          label: "Escript RAR"
        }

        when: {
          sql: ${TABLE}.RX_SOURCE = 26 ;;
          label: "Escript Addfill"
        }

        when: {
          sql: ${TABLE}.RX_SOURCE = 27 ;;
          label: "Patient Request"
        }

        when: {
          sql: ${TABLE}.RX_SOURCE = 28 ;;
          label: "Prescriber Request"
        }

        when: {
          sql: ${TABLE}.RX_SOURCE = 29 ;;
          label: "Other"
        }

        when: {
          sql: true ;;
          label: "Blank"
        }
      }
    }

    dimension: partial_fill_bill_type {
      label: "Prescription Partial Fill Bill Type"
      description: "Flag that indicates on a partial fill transaction, whether both the partial fill and completion fill are billed to a third party as the entire quantity or as separate quantities. This field is EPS only!!!"
      type: string

      case: {
        when: {
          sql: ${TABLE}.RX_TX_PARTIAL_FILL_BILL_TYPE = 'B' ;;
          label: "Billed Separately"
        }

        when: {
          sql: ${TABLE}.RX_TX_PARTIAL_FILL_BILL_TYPE = 'C' ;;
          label: "Billed When Completion Is Filled"
        }

        when: {
          sql: ${TABLE}.RX_TX_PARTIAL_FILL_BILL_TYPE = 'P' ;;
          label: "Billed When Partial Is Filled"
        }

        when: {
          sql: true ;;
          label: "Not Billed as Partial or Completion"
        }
      }
    }

    dimension: 340b {
      label: "Prescription 340B"
      description: "Yes/No flag indicating if the transaction is a 340B transaction. This field is EPS only!!!"
      type: yesno
      sql: ${TABLE}.RX_TX_IS_340B = 'Y' ;;
    }

    dimension: rx_on_file {
      label: "Prescription On File"
      description: "Yes/No flag indicating if the prescription is On File. This field is EPS only!!!"
      type: yesno
      sql: ${TABLE}.RX_ON_FILE = 'Y' ;;
    }

    dimension: wholesale_order {
      label: "Prescription Wholesale Order"
      description: "Yes/No flag indicating if the prescription is a part of wholesale orders. Value populated at the time of Order Entry Confirmation. If the Record type of the selected patient is “Office”, then the prescription is a wholesale order. This field is EPS only!!!"
      type: yesno
      sql: ${TABLE}.RX_WHOLESALE_ORDER_FLAG = 'Y' ;;
    }

    dimension: controlled_substance_escript {
      label: "Prescription Controlled Substance Escript"
      description: "Yes/No flag indicating prescription was generated from a controlled substance escript. Used to identify prescriptions for  auditing and RX edits requirement. This field is EPS only!!!"
      type: yesno
      sql: ${TABLE}.RX_CONTROLLED_SUBSTANCE_ESCRIPT_FLAG = 'Y' ;;
    }

    dimension: ncpdp_route {
      label: "Prescription NCPDP Route"
      description: "Route that is normally used by the patient for using/taking a compound. This field is EPS only!!!"
      type: string
      sql: ${TABLE}.RX_NCPDP_ROUTE ;;
    }

    ################################################################################################## End of Dimensions #################################################################################################

    ####################################################################################################### Measures ####################################################################################################

    # This measure is used only in store explore to determine the no. of prescription transactions that were filled
    measure: store_rx_tx_fill_count {
      label: "Store Prescription Fill Count"
      type: count_distinct
      sql: ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${tx_number} ||'@'|| ${rx_number} ;; #ERXLPS-1649
      value_format: "#,##0"
    }

    measure: avg_fill_time {
      label: "Average Fill Time"
      type: average
      sql: (${fill_time}) ;;
    }

    measure: count {
      label: "Total Scripts"
      description: "Total Scripts for Active fills"
      type: count_distinct
      # If This view in the future is broken to include rejects, on-holds then the logic will need to change & probably a new field for Active Scripts may be required at that point
      sql: (CASE WHEN ${TABLE}.LAST_YEAR = 'No' THEN (${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${tx_number}) END) ;;
      value_format: "#,##0"
      drill_fields: [detail*]
    }

    measure: count_last_year {
      label: "LY Total Scripts"
      description: "Total Scripts for Active fills for last year based on the period selected"
      type: count_distinct
      # If This view in the future is broken to include rejects, on-holds then the logic will need to change & probably a new field for Active Scripts may be required at that point
      sql: (CASE WHEN ${TABLE}.LAST_YEAR = 'Yes' THEN (${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${tx_number}) END) ;;
      value_format: "#,##0"
      drill_fields: [detail*]
    }

    measure: count_variance {
      label: "TY/LY Total Scripts Variance %"
      description: "Percentage Increase/Decrease of the Active Prescription Fills compared to the Last Year"
      type: number
      sql: (${count} - ${count_last_year})/NULLIF(${count_last_year},0) ;;
      value_format: "00.00%"
      drill_fields: [detail*]
    }

    #     html: |
    #         {% if value < 0 %}
    #           <b><p style="color: white; background-color: #dc7350; font-size:100%; text-align:center; margin: 0; border-radius: 5px;">{{ rendered_value }}</p></b>
    #         {% else %}
    #           <b><p style="color: white; background-color: #20D76C; font-size:100%; text-align:center; margin: 0; border-radius: 5px;">{{ rendered_value }}</p></b>
    #         {% endif %}

    measure: count_new {
      label: "New Scripts"
      description: "Total New Scripts for Active fills"
      type: count_distinct
      sql: (CASE WHEN ${TABLE}.RX_TX_FILL_STATUS = 'N' AND ${TABLE}.LAST_YEAR = 'No' THEN (${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${tx_number}) END) ;;
      value_format: "#,##0"
      drill_fields: [detail*]
    }

    measure: count_new_last_year {
      label: "LY New Scripts"
      description: "Total New Scripts for Active fills for last year based on the period selected"
      type: count_distinct
      sql: (CASE WHEN ${TABLE}.RX_TX_FILL_STATUS = 'N' AND ${TABLE}.LAST_YEAR = 'Yes' THEN (${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${tx_number}) END) ;;
      value_format: "#,##0"
      drill_fields: [detail*]
    }

    measure: count_new_variance {
      label: "TY/LY New Scripts Variance %"
      description: "Percentage Increase/Decrease of the New Scripts for Active Fills compared to the Last Year"
      type: number
      sql: (${count_new} - ${count_new_last_year})/NULLIF(${count_new_last_year},0) ;;
      value_format: "00.00%"
      drill_fields: [detail*]
    }

    #     html: |
    #         {% if value < 0 %}
    #           <b><p style="color: white; background-color: #dc7350; font-size:100%; text-align:center; margin: 0; border-radius: 5px;">{{ rendered_value }}</p></b>
    #         {% else %}
    #           <b><p style="color: white; background-color: #20D76C; font-size:100%; text-align:center; margin: 0; border-radius: 5px;">{{ rendered_value }}</p></b>
    #         {% endif %}

    measure: count_new_pct {
      label: "New Scripts %"
      description: "Percentage of the New Scripts in comparisson to the Total Scripts for Active Fills"
      type: number
      sql: ${count_new}/${count} ;;
      value_format: "00.00%"
      drill_fields: [detail*]
    }

    measure: count_refill {
      label: "Refill Scripts"
      description: "Total Refill Scripts for Active fills"
      type: count_distinct
      sql: (CASE WHEN ${TABLE}.RX_TX_FILL_STATUS = 'R' AND ${TABLE}.LAST_YEAR = 'No' THEN (${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${tx_number}) END) ;;
      value_format: "#,##0"
      drill_fields: [detail*]
    }

    measure: count_refill_last_year {
      label: "LY Refill Scripts"
      description: "Total Refill Scripts for Active fills for last year based on the period selected"
      type: count_distinct
      sql: (CASE WHEN ${TABLE}.RX_TX_FILL_STATUS = 'R' AND ${TABLE}.LAST_YEAR = 'Yes' THEN (${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${tx_number}) END) ;;
      value_format: "#,##0"
      drill_fields: [detail*]
    }

    #     html: |
    #         {% if value < 0 %}
    #           <b><p style="color: white; background-color: #dc7350; font-size:100%; text-align:center; margin: 0; border-radius: 5px;">{{ rendered_value }}</p></b>
    #         {% else %}
    #           <b><p style="color: white; background-color: #20D76C; font-size:100%; text-align:center; margin: 0; border-radius: 5px;">{{ rendered_value }}</p></b>
    #         {% endif %}

    measure: count_refill_variance {
      label: "TY/LY Refill Scripts Variance %"
      description: "Percentage Increase/Decrease of the Refill Scripts for Active Fills compared to the Last Year"
      type: number
      sql: (${count_refill} - ${count_refill_last_year})/NULLIF(${count_refill_last_year},0) ;;
      value_format: "00.00%"
      drill_fields: [detail*]
    }

    measure: count_refill_pct {
      label: "Refill Scripts %"
      description: "Percentage of the Refill Scripts in comparisson to the Total Scripts for Active Fills"
      type: number
      sql: ${count_refill}/${count} ;;
      value_format: "00.00%"
      drill_fields: [detail*]
    }

    measure: count_generic {
      label: "Generic Scripts"
      description: "Total Generic Scripts for Active fills"
      type: count_distinct
      sql: (CASE WHEN ${drug.drug_multi_source} = 'Y' AND ${TABLE}.LAST_YEAR = 'No' THEN (${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${tx_number}) END) ;;
      value_format: "#,##0"
      drill_fields: [detail*]
    }

    measure: count_generic_last_year {
      label: "LY Generic Scripts"
      description: "Total Generic Scripts for Active fills for last year based on the period selected"
      type: count_distinct
      sql: (CASE WHEN ${drug.drug_multi_source} = 'Y' AND ${TABLE}.LAST_YEAR = 'Yes' THEN (${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${tx_number}) END) ;;
      value_format: "#,##0"
      drill_fields: [detail*]
    }

    measure: count_generic_variance {
      label: "TY/LY Generic Scripts Variance %"
      description: "Percentage Increase/Decrease of the Generic Scripts for Active Fills compared to the Last Year"
      type: number
      sql: (${count_generic} - ${count_generic_last_year})/NULLIF(${count_generic_last_year},0) ;;
      value_format: "00.00%"
      drill_fields: [detail*]
    }

    #     html: |
    #         {% if value < 0 %}
    #           <b><p style="color: white; background-color: #dc7350; font-size:100%; text-align:center; margin: 0; border-radius: 5px;">{{ rendered_value }}</p></b>
    #         {% else %}
    #           <b><p style="color: white; background-color: #20D76C; font-size:100%; text-align:center; margin: 0; border-radius: 5px;">{{ rendered_value }}</p></b>
    #         {% endif %}

    measure: count_generic_pct {
      label: "Generic Scripts %"
      description: "Percentage of the Generic Scripts in comparisson to the Total Scripts for Active Fills"
      type: number
      sql: ${count_generic}/${count} ;;
      value_format: "00.00%"
      drill_fields: [detail*]
    }

    measure: count_brand {
      label: "Brand Scripts"
      description: "Total Brand Scripts for Active fills"
      type: count_distinct
      sql: (CASE WHEN ${drug.drug_multi_source} <> 'Y' AND ${TABLE}.LAST_YEAR = 'No' THEN (${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${tx_number}) END) ;;
      value_format: "#,##0"
      drill_fields: [detail*]
    }

    measure: count_brand_last_year {
      label: "LY Brand Scripts"
      description: "Total Brand Scripts for Active fills for last year based on the period selected"
      type: count_distinct
      sql: (CASE WHEN ${drug.drug_multi_source} <> 'Y' AND ${TABLE}.LAST_YEAR = 'Yes' THEN (${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${tx_number}) END) ;;
      value_format: "#,##0"
      drill_fields: [detail*]
    }

    measure: count_brand_variance {
      label: "TY/LY Brand Scripts Variance %"
      description: "Percentage Increase/Decrease of the Brand Scripts for Active Fills compared to the Last Year"
      type: number
      sql: (${count_brand} - ${count_brand_last_year})/NULLIF(${count_brand_last_year},0) ;;
      value_format: "00.00%"
      drill_fields: [detail*]
    }

    #     html: |
    #         {% if value < 0 %}
    #           <b><p style="color: white; background-color: #dc7350; font-size:100%; text-align:center; margin: 0; border-radius: 5px;">{{ rendered_value }}</p></b>
    #         {% else %}
    #           <b><p style="color: white; background-color: #20D76C; font-size:100%; text-align:center; margin: 0; border-radius: 5px;">{{ rendered_value }}</p></b>
    #         {% endif %}

    measure: count_brand_pct {
      label: "Brand Scripts %"
      description: "Percentage of the Branded Scripts in comparisson to the Total Scripts for Active Fills"
      type: number
      sql: ${count_brand}/${count} ;;
      value_format: "00.00%"
      drill_fields: [detail*]
    }

    measure: count_cash {
      label: "Cash Scripts"
      description: "Total Cash Scripts for Active fills"
      type: count_distinct
      sql: (CASE WHEN NVL(${TABLE}.RX_TX_TP_BILL,'N') = 'N' AND ${TABLE}.LAST_YEAR = 'No' THEN (${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${tx_number}) END) ;;
      value_format: "#,##0"
      drill_fields: [detail*]
    }

    measure: count_cash_last_year {
      label: "LY Cash Scripts"
      description: "Total Cash Scripts for Active fills for last year based on the period selected"
      type: count_distinct
      sql: (CASE WHEN NVL(${TABLE}.RX_TX_TP_BILL,'N') = 'N' AND ${TABLE}.LAST_YEAR = 'Yes' THEN (${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${tx_number}) END) ;;
      value_format: "#,##0"
      drill_fields: [detail*]
    }

    measure: count_cash_variance {
      label: "TY/LY Cash Scripts Variance %"
      description: "Percentage Increase/Decrease of the Cash Scripts for Active Fills compared to the Last Year"
      type: number
      sql: (${count_cash} - ${count_cash_last_year})/NULLIF(${count_cash_last_year},0) ;;
      value_format: "00.00%"
      drill_fields: [detail*]
    }

    #     html: |
    #         {% if value < 0 %}
    #           <b><p style="color: white; background-color: #dc7350; font-size:100%; text-align:center; margin: 0; border-radius: 5px;">{{ rendered_value }}</p></b>
    #         {% else %}
    #           <b><p style="color: white; background-color: #20D76C; font-size:100%; text-align:center; margin: 0; border-radius: 5px;">{{ rendered_value }}</p></b>
    #         {% endif %}

    measure: count_cash_pct {
      label: "Cash Scripts %"
      description: "Percentage of the Cash Scripts in comparisson to the Total Scripts for Active Fills"
      type: number
      sql: ${count_cash}/${count} ;;
      value_format: "00.00%"
      drill_fields: [detail*]
    }

    measure: count_tp {
      label: "TP Scripts"
      description: "Total Third Party Scripts for Active fills"
      type: count_distinct
      sql: (CASE WHEN NVL(${TABLE}.RX_TX_TP_BILL,'N') = 'Y' AND ${TABLE}.LAST_YEAR = 'No' THEN (${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${tx_number}) END) ;;
      value_format: "#,##0"
      drill_fields: [detail*]
    }

    measure: count_tp_last_year {
      label: "LY TP Scripts"
      description: "Total Third Party Scripts for Active fills for last year based on the period selected"
      type: count_distinct
      sql: (CASE WHEN NVL(${TABLE}.RX_TX_TP_BILL,'N') = 'Y' AND ${TABLE}.LAST_YEAR = 'Yes' THEN (${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${tx_number}) END) ;;
      value_format: "#,##0"
      drill_fields: [detail*]
    }

    measure: count_tp_variance {
      label: "TY/LY TP Scripts Variance %"
      description: "Percentage Increase/Decrease of the Third Party Scripts for Active Fills compared to the Last Year"
      type: number
      sql: (${count_tp} - ${count_tp_last_year})/NULLIF(${count_tp_last_year},0) ;;
      value_format: "00.00%"
      drill_fields: [detail*]
    }

    #     html: |
    #         {% if value < 0 %}
    #           <b><p style="color: white; background-color: #dc7350; font-size:100%; text-align:center; margin: 0; border-radius: 5px;">{{ rendered_value }}</p></b>
    #         {% else %}
    #           <b><p style="color: white; background-color: #20D76C; font-size:100%; text-align:center; margin: 0; border-radius: 5px;">{{ rendered_value }}</p></b>
    #         {% endif %}

    measure: count_tp_pct {
      label: "TP Scripts %"
      description: "Percentage of the Third Party Scripts in comparisson to the Total Scripts for Active Fills"
      type: number
      sql: ${count_tp}/${count} ;;
      value_format: "00.00%"
      drill_fields: [detail*]
    }

    measure: sum_price {
      label: "Total Sales"
      description: "Total Price of prescription"
      type: sum
      sql: (CASE WHEN ${TABLE}.LAST_YEAR = 'No' THEN ${TABLE}.RX_TX_PRICE END) ;;
      value_format: "$#,##0.00;($#,##0.00)"
      drill_fields: [detail*]
    }

    measure: sum_price_last_year {
      label: "LY Total Sales"
      description: "Total Price of prescription for last year based on the period selected"
      type: sum
      sql: (CASE WHEN ${TABLE}.LAST_YEAR = 'Yes' THEN ${TABLE}.RX_TX_PRICE END) ;;
      value_format: "$#,##0.00;($#,##0.00)"
      drill_fields: [detail*]
    }

    measure: sum_price_variance {
      label: "TY/LY Sales Variance %"
      description: "Percentage Increase/Decrease of the Total Prescription Price compared to the Last Year"
      type: number
      sql: (${sum_price} - ${sum_price_last_year})/NULLIF(${sum_price_last_year},0) ;;
      value_format: "00.00%"
      drill_fields: [detail*]
    }

    #     html: |
    #         {% if value < 0 %}
    #           <b><p style="color: white; background-color: #dc7350; font-size:100%; text-align:center; margin: 0; border-radius: 5px;">{{ rendered_value }}</p></b>
    #         {% else %}
    #           <b><p style="color: white; background-color: #20D76C; font-size:100%; text-align:center; margin: 0; border-radius: 5px;">{{ rendered_value }}</p></b>
    #         {% endif %}

    measure: sum_price_generic {
      label: "Generic Sales"
      description: "Total Price of prescription for Generic Drugs"
      type: sum
      sql: (CASE WHEN ${drug.drug_multi_source} = 'Y' AND ${TABLE}.LAST_YEAR = 'No' THEN ${TABLE}.RX_TX_PRICE END) ;;
      value_format: "$#,##0.00;($#,##0.00)"
      drill_fields: [detail*]
    }

    measure: sum_price_generic_last_year {
      label: "LY Generic Sales"
      description: "Total Price of prescription for Generic Drugs for last year based on the period selected"
      type: sum
      sql: (CASE WHEN ${drug.drug_multi_source} = 'Y' AND ${TABLE}.LAST_YEAR = 'Yes' THEN ${TABLE}.RX_TX_PRICE END) ;;
      value_format: "$#,##0.00;($#,##0.00)"
      drill_fields: [detail*]
    }

    measure: sum_price_generic_variance {
      label: "TY/LY Generic Sales Variance %"
      description: "Percentage Increase/Decrease of the Prescription Price for Generic Drugs compared to the Last Year"
      type: number
      sql: (${sum_price_generic} - ${sum_price_generic_last_year})/NULLIF(${sum_price_generic_last_year},0) ;;
      value_format: "00.00%"
      drill_fields: [detail*]
    }

    measure: sum_price_generic_pct {
      label: "Generic Sales %"
      description: "% Sales for Generic Drugs.  Formula Used: ( Prescription Price - Generic/Prescription Price - Total)"
      type: number
      sql: ${sum_price_generic}/nullif(${sum_price}, 0) ;;
      value_format: "00.00%"
      drill_fields: [detail*]
    }

    measure: sum_price_brand {
      label: "Brand Sales"
      description: "Total Price of prescription for Branded Drugs"
      type: sum
      sql: (CASE WHEN ${drug.drug_multi_source} <> 'Y' AND ${TABLE}.LAST_YEAR = 'No' THEN ${TABLE}.RX_TX_PRICE END) ;;
      value_format: "$#,##0.00;($#,##0.00)"
      drill_fields: [detail*]
    }

    measure: sum_price_brand_last_year {
      label: "LY Brand Sales"
      description: "Total Price of prescription for Branded Drugs for last year based on the period selected"
      type: sum
      sql: (CASE WHEN ${drug.drug_multi_source} <> 'Y' AND ${TABLE}.LAST_YEAR = 'Yes' THEN ${TABLE}.RX_TX_PRICE END) ;;
      value_format: "$#,##0.00;($#,##0.00)"
      drill_fields: [detail*]
    }

    measure: sum_price_brand_variance {
      label: "TY/LY Brand Sales Variance %"
      description: "Percentage Increase/Decrease of the Prescription Price for Branded Drugs compared to the Last Year"
      type: number
      sql: (${sum_price_brand} - ${sum_price_brand_last_year})/NULLIF(${sum_price_brand_last_year},0) ;;
      value_format: "00.00%"
      drill_fields: [detail*]
    }

    measure: sum_price_brand_pct {
      label: "Brand Sales %"
      description: "% Sales for Branded Drugs.  Formula Used: ( Prescription Price - Brand/Prescription Price - Total)"
      type: number
      sql: ${sum_price_brand}/nullif(${sum_price},0) ;;
      value_format: "00.00%"
      drill_fields: [detail*]
    }

    measure: sum_price_cash {
      label: "Cash Sales"
      description: "Total Price of prescription for Cash Transactions"
      type: sum
      sql: (CASE WHEN NVL(${TABLE}.RX_TX_TP_BILL,'N') = 'N' AND ${TABLE}.LAST_YEAR = 'No' THEN ${TABLE}.RX_TX_PRICE END) ;;
      value_format: "$#,##0.00;($#,##0.00)"
      drill_fields: [detail*]
    }

    measure: sum_price_cash_last_year {
      label: "LY Cash Sales"
      description: "Total Price of prescription for Cash Transactions for last year based on the period selected"
      type: sum
      sql: (CASE WHEN NVL(${TABLE}.RX_TX_TP_BILL,'N') = 'N' AND ${TABLE}.LAST_YEAR = 'Yes' THEN ${TABLE}.RX_TX_PRICE END) ;;
      value_format: "$#,##0.00;($#,##0.00)"
      drill_fields: [detail*]
    }

    measure: sum_price_cash_variance {
      label: "TY/LY Cash Sales Variance %"
      description: "Percentage Increase/Decrease of the Prescription Price for Cash Transactions compared to the Last Year"
      type: number
      sql: (${sum_price_cash} - ${sum_price_cash_last_year})/NULLIF(${sum_price_cash_last_year},0) ;;
      value_format: "00.00%"
      drill_fields: [detail*]
    }

    measure: sum_price_cash_pct {
      label: "Cash Sales %"
      description: "% Sales for Cash Transactions.  Formula Used: ( Prescription Price - Cash / Prescription Price - Total)"
      type: number
      sql: ${sum_price_cash}/nullif(${sum_price}, 0) ;;
      value_format: "00.00%"
      drill_fields: [detail*]
    }

    measure: sum_price_tp {
      label: "TP Sales"
      description: "Total Price of prescription for Third Party Transactions"
      type: sum
      sql: (CASE WHEN NVL(${TABLE}.RX_TX_TP_BILL,'N') = 'Y' AND ${TABLE}.LAST_YEAR = 'No' THEN ${TABLE}.RX_TX_PRICE END) ;;
      value_format: "$#,##0.00;($#,##0.00)"
      drill_fields: [detail*]
    }

    measure: sum_price_tp_last_year {
      label: "LY TP Sales"
      description: "Total Price of prescription for Third Party Transactions for last year based on the period selected"
      type: sum
      sql: (CASE WHEN NVL(${TABLE}.RX_TX_TP_BILL,'N') = 'Y' AND ${TABLE}.LAST_YEAR = 'Yes' THEN ${TABLE}.RX_TX_PRICE END) ;;
      value_format: "$#,##0.00;($#,##0.00)"
      drill_fields: [detail*]
    }

    measure: sum_price_tp_variance {
      label: "TY/LY TP Sales Variance %"
      description: "Percentage Increase/Decrease of the Prescription Price for Third Party Transactions compared to the Last Year"
      type: number
      sql: (${sum_price_tp} - ${sum_price_tp_last_year})/NULLIF(${sum_price_tp_last_year},0) ;;
      value_format: "00.00%"
      drill_fields: [detail*]
    }

    measure: sum_price_tp_pct {
      label: "TP Sales %"
      description: "% Sales for Third Party Transactions.  Formula Used: ( Prescription Price - Third Party / Prescription Price - Total)"
      type: number
      sql: ${sum_price_tp}/nullif(${sum_price}, 0) ;;
      value_format: "00.00%"
      drill_fields: [detail*]
    }

    measure: sum_other_price {
      label: "Prescription Other Price"
      description: "The total price of the other drug (brand/generic) that was not used in the dispensing of this prescription"
      type: sum
      sql: (CASE WHEN ${TABLE}.LAST_YEAR = 'No' THEN ${TABLE}.RX_TX_OTHER_PRICE END) ;;
      value_format: "$#,##0.00;($#,##0.00)"
    }

    measure: sum_acquisition_cost {
      label: "Prescription ACQ Cost"
      description: "Represents the total acquisition cost of filled drug used on the prescription transaction record"
      type: sum
      sql: (CASE WHEN ${TABLE}.LAST_YEAR = 'No' THEN ${TABLE}.RX_TX_ACQUISITION_COST END) ;;
      value_format: "$#,##0.00;($#,##0.00)"
    }

    measure: sum_acquisition_cost_last_year {
      label: "LY Prescription ACQ Cost"
      description: "Represents the total acquisition cost of filled drug used on the prescription transaction record for last year based on the period selected"
      type: sum
      sql: (CASE WHEN ${TABLE}.LAST_YEAR = 'Yes' THEN ${TABLE}.RX_TX_ACQUISITION_COST END) ;;
      value_format: "$#,##0.00;($#,##0.00)"
      drill_fields: [detail*]
    }

    measure: sum_acquisition_cost_variance {
      label: "TY/LY Prescription ACQ $ Variance"
      description: "$ Increase/Decrease of the total acquisition cost of filled drug on the prescription transaction compared to the Last Year"
      type: number
      sql: (${sum_acquisition_cost} - ${sum_acquisition_cost_last_year}) ;;
      value_format: "$#,##0.00;($#,##0.00)"
      drill_fields: [detail*]
    }

    #     html: |
    #         {% if value < 0 %}
    #           <b><p style="color: white; background-color: #dc7350; font-size:100%; text-align:center; margin: 0; border-radius: 5px;">{{ rendered_value }}</p></b>
    #         {% else %}
    #           <b><p style="color: white; background-color: #20D76C; font-size:100%; text-align:center; margin: 0; border-radius: 5px;">{{ rendered_value }}</p></b>
    #         {% endif %}

    measure: sum_margin {
      label: "Prescription Gross Margin %"
      description: "Margin % of the prescription. Formula Used: ( (Total Price of prescription - Total Acquisition Cost of prescription)/Total Price of prescription)"
      type: number
      sql: (${sum_price} - ${sum_acquisition_cost})/NULLIF(${sum_price},0) ;;
      value_format: "00.00%"
      drill_fields: [detail*]
    }

    #     html: |
    #         {% if value < 0 %}
    #           <b><p style="color: white; background-color: #dc7350; font-size:100%; text-align:center; margin: 0; border-radius: 5px;">{{ rendered_value }}</p></b>
    #         {% elsif value < 20 %}
    #           <b><p style="color: black; background-color: #e9b404; font-size:100%; text-align:center; margin: 0; border-radius: 5px;">{{ rendered_value }}</p></b>
    #         {% else %}
    #           <b><p style="color: white; background-color: #20D76C; font-size:100%; text-align:center; margin: 0; border-radius: 5px;">{{ rendered_value }}</p></b>
    #         {% endif %}

    measure: sum_margin_last_year {
      label: "LY Prescription Gross Margin %"
      description: "Margin % of the prescription for the last year based on the Period Selected. Formula Used: ( (LY Total Price of prescription - LY Total Acquisition Cost of prescription)/LY Total Price of prescription)"
      type: number
      sql: (${sum_price_last_year} - ${sum_acquisition_cost_last_year})/NULLIF(${sum_price_last_year},0) ;;
      value_format: "00.00%"
      drill_fields: [detail*]
    }

    #     html: |
    #         {% if value < 0 %}
    #           <b><p style="color: white; background-color: #dc7350; font-size:100%; text-align:center; margin: 0; border-radius: 5px;">{{ rendered_value }}</p></b>
    #         {% elsif value < 20 %}
    #           <b><p style="color: black; background-color: #e9b404; font-size:100%; text-align:center; margin: 0; border-radius: 5px;">{{ rendered_value }}</p></b>
    #         {% else %}
    #           <b><p style="color: white; background-color: #20D76C; font-size:100%; text-align:center; margin: 0; border-radius: 5px;">{{ rendered_value }}</p></b>
    #         {% endif %}

    measure: sum_margin_variance {
      label: "TY/LY Prescription Gross Margin Variance %"
      description: "Margin % Increase/Decrease of the Prescription compared to the Last Year"
      type: number
      sql: (${sum_margin} - ${sum_margin_last_year})/NULLIF(${sum_margin_last_year},0) ;;
      value_format: "00.00%"
      drill_fields: [detail*]
    }

    #     html: |
    #         {% if value < 0 %}
    #           <b><p style="color: white; background-color: #dc7350; font-size:100%; text-align:center; margin: 0; border-radius: 5px;">{{ rendered_value }}</p></b>
    #         {% elsif value < 20 %}
    #           <b><p style="color: black; background-color: #e9b404; font-size:100%; text-align:center; margin: 0; border-radius: 5px;">{{ rendered_value }}</p></b>
    #         {% else %}
    #           <b><p style="color: white; background-color: #20D76C; font-size:100%; text-align:center; margin: 0; border-radius: 5px;">{{ rendered_value }}</p></b>
    #         {% endif %}

    measure: sum_margin_dollars {
      label: "Prescription Gross Margin $"
      description: "Margin $ of the Prescription. Formula Used: ( (Total Price of prescription - Total Acquisition Cost of prescription))"
      type: number
      sql: (${sum_price} - ${sum_acquisition_cost}) ;;
      value_format: "$#,##0.00;($#,##0.00)"
      drill_fields: [detail*]
    }

    #     html: |
    #         {% if value < 0 %}
    #           <b><p style="color: white; background-color: #dc7350; font-size:100%; text-align:center; margin: 0; border-radius: 5px;"><a href="{{ link }}">{{ rendered_value }}</a></p></b>
    #         {% elsif value < 20 %}
    #           <b><p style="color: white; background-color: #e9b404; font-size:100%; text-align:center; margin: 0; border-radius: 5px;"><a href="{{ link }}">{{ rendered_value }}</a></p></b>
    #         {% else %}
    #           <b><p style="color: white; background-color: #20D76C; font-size:100%; text-align:center; margin: 0; border-radius: 5px;"><a href="{{ link }}">{{ rendered_value }}</a></p></b>
    #         {% endif %}

    measure: sum_margin_dollars_last_year {
      label: "LY Prescription Gross Margin $"
      description: "Margin $ of the Prescription for the last year based on the Period Selected. Formula Used: ( (LY Total Price of prescription - LY Total Acquisition Cost of prescription))"
      type: number
      sql: (${sum_price_last_year} - ${sum_acquisition_cost_last_year}) ;;
      value_format: "$#,##0.00;($#,##0.00)"
      drill_fields: [detail*]
    }

    #     html: |
    #         {% if value < 0 %}
    #           <b><p style="color: white; background-color: #dc7350; font-size:100%; text-align:center; margin: 0; border-radius: 5px;">{{ rendered_value }}</p></b>
    #         {% elsif value < 20 %}
    #           <b><p style="color: black; background-color: #e9b404; font-size:100%; text-align:center; margin: 0; border-radius: 5px;">{{ rendered_value }}</p></b>
    #         {% else %}
    #           <b><p style="color: white; background-color: #20D76C; font-size:100%; text-align:center; margin: 0; border-radius: 5px;">{{ rendered_value }}</p></b>
    #         {% endif %}

    measure: sum_margin_dollars_variance {
      label: "TY/LY Prescription Gross Margin $ Variance"
      description: "Margin $ Increase/Decrease of the Prescription compared to the Last Year"
      type: number
      sql: (${sum_margin_dollars} - ${sum_margin_dollars_last_year}) ;;
      value_format: "$#,##0.00;($#,##0.00)"
      drill_fields: [detail*]
    }

    #     html: |
    #         {% if value < 0 %}
    #           <b><p style="color: white; background-color: #dc7350; font-size:100%; text-align:center; margin: 0; border-radius: 5px;">{{ rendered_value }}</p></b>
    #         {% elsif value < 20 %}
    #           <b><p style="color: black; background-color: #e9b404; font-size:100%; text-align:center; margin: 0; border-radius: 5px;">{{ rendered_value }}</p></b>
    #         {% else %}
    #           <b><p style="color: white; background-color: #20D76C; font-size:100%; text-align:center; margin: 0; border-radius: 5px;">{{ rendered_value }}</p></b>
    #         {% endif %}

    measure: sum_uc_price {
      label: "Prescription U&C Price"
      description: "Total Usual and Customary Price of the prescription of the drug filled"
      type: sum
      sql: ${TABLE}.RX_TX_UC_PRICE ;;
      value_format: "$#,##0.00;($#,##0.00)"
      drill_fields: [detail*]
    }

    measure: avg_price {
      label: "Avg Prescription Price - Total"
      description: "Average Prescription Price"
      type: average
      sql: CASE WHEN ${TABLE}.LAST_YEAR = 'No' THEN ${TABLE}.RX_TX_PRICE END ;;
      value_format: "$#,##0.00;($#,##0.00)"
    }

    measure: avg_price_generic {
      label: "Avg Prescription Price - Generic"
      description: "Average Prescription Price for Generic Drugs"
      type: average
      sql: (CASE WHEN ${drug.drug_multi_source} = 'Y' AND ${TABLE}.LAST_YEAR = 'No' THEN ${TABLE}.RX_TX_PRICE END) ;;
      value_format: "$#,##0.00;($#,##0.00)"
    }

    measure: avg_price_brand {
      label: "Avg Prescription Price - Brand"
      description: "Average Prescription Price for Branded Drugs"
      type: average
      sql: (CASE WHEN ${drug.drug_multi_source} <> 'Y' AND ${TABLE}.LAST_YEAR = 'No' THEN ${TABLE}.RX_TX_PRICE END) ;;
      value_format: "$#,##0.00;($#,##0.00)"
    }

    measure: avg_price_cash {
      label: "Avg Prescription Price - Cash"
      description: "Average Prescription Price for Cash Transactions"
      type: average
      sql: (CASE WHEN NVL(${TABLE}.RX_TX_TP_BILL,'N') = 'N' AND ${TABLE}.LAST_YEAR = 'No' THEN ${TABLE}.RX_TX_PRICE END) ;;
      value_format: "$#,##0.00;($#,##0.00)"
    }

    measure: avg_price_tp {
      label: "Avg Prescription Price - T/P"
      description: "Average Prescription Price for Third Party Transactions"
      type: average
      sql: (CASE WHEN NVL(${TABLE}.RX_TX_TP_BILL,'N') = 'Y' AND ${TABLE}.LAST_YEAR = 'No' THEN ${TABLE}.RX_TX_PRICE END) ;;
      value_format: "$#,##0.00;($#,##0.00)"
    }

    measure: avg_acquisition_cost {
      label: "Avg Prescription ACQ Cost - Total"
      description: "Average Acquisition Cost for Generic Drugs"
      type: average
      sql: (CASE WHEN ${TABLE}.LAST_YEAR = 'No' THEN ${TABLE}.RX_TX_ACQUISITION_COST END) ;;
      value_format: "$#,##0.00;($#,##0.00)"
    }

    measure: avg_acquisition_cost_generic {
      label: "Avg Prescription ACQ Cost - Generic"
      description: "Average Acquisition Cost for Generic Drugs"
      type: average
      sql: (CASE WHEN ${drug.drug_multi_source} = 'Y' AND ${TABLE}.LAST_YEAR = 'No' THEN ${TABLE}.RX_TX_ACQUISITION_COST END) ;;
      value_format: "$#,##0.00;($#,##0.00)"
    }

    measure: avg_acquisition_cost_brand {
      label: "Avg Prescription ACQ Cost - Brand"
      description: "Average Acquisition Cost for Branded Drugs"
      type: average
      sql: (CASE WHEN ${drug.drug_multi_source} <> 'Y' AND ${TABLE}.LAST_YEAR = 'No' THEN ${TABLE}.RX_TX_ACQUISITION_COST END) ;;
      value_format: "$#,##0.00;($#,##0.00)"
    }

    measure: avg_acquisition_cost_cash {
      label: "Avg Prescription ACQ Cost - Cash"
      description: "Average Acquisition Cost for Cash Transactions"
      type: average
      sql: (CASE WHEN NVL(${TABLE}.RX_TX_TP_BILL,'N') = 'N' AND ${TABLE}.LAST_YEAR = 'No' THEN ${TABLE}.RX_TX_ACQUISITION_COST END) ;;
      value_format: "$#,##0.00;($#,##0.00)"
    }

    measure: avg_acquisition_cost_tp {
      label: "Avg Prescription ACQ Cost - TP"
      description: "Average Acquisition Cost for Third Party Transactions"
      type: average
      sql: (CASE WHEN NVL(${TABLE}.RX_TX_TP_BILL,'N') = 'Y' AND ${TABLE}.LAST_YEAR = 'No' THEN ${TABLE}.RX_TX_ACQUISITION_COST END) ;;
      value_format: "$#,##0.00;($#,##0.00)"
    }

    measure: avg_margin_dollars {
      label: "Avg Prescription Gross Margin $ - Total"
      description: "Average Margin $ of the Prescription. Formula Used: ( (Average Price of prescription - Average ACQ Cost of prescription))"
      type: number
      sql: (${avg_price} - ${avg_acquisition_cost}) ;;
      value_format: "$#,##0.00;($#,##0.00)"
    }

    measure: avg_margin_generic {
      label: "Avg Prescription Gross Margin $ - Generic"
      description: "Average Margin $ of the Prescription for Generic Drugs. Formula Used: ( (Average Price of prescription for Generic Drugs - Average ACQ Cost of prescription for Generic Drugs))"
      type: number
      sql: (${avg_price_generic} - ${avg_acquisition_cost_generic}) ;;
      value_format: "$#,##0.00;($#,##0.00)"
    }

    measure: avg_margin_brand {
      label: "Avg Prescription Gross Margin $ - Brand"
      description: "Average Margin $ of the Prescription for Branded Drugs. Formula Used: ( (Average Price of prescription for Branded Drugs - Average ACQ Cost of prescription for Branded Drugs))"
      type: number
      sql: (${avg_price_brand} - ${avg_acquisition_cost_brand}) ;;
      value_format: "$#,##0.00;($#,##0.00)"
    }

    measure: avg_margin_cash {
      label: "Avg Prescription Gross Margin $ - Cash"
      description: "Average Margin $ of the Prescription for Cash Transactions. Formula Used: ( (Average Price of prescription for Cash Transactions - Average ACQ Cost of prescription for Cash Transactions))"
      type: number
      sql: (${avg_price_cash} - ${avg_acquisition_cost_cash}) ;;
      value_format: "$#,##0.00;($#,##0.00)"
    }

    measure: avg_margin_tp {
      label: "Avg Prescription Gross Margin $ - TP"
      description: "Average Margin $ of the Prescription for Third Party Transactions. Formula Used: ( (Average Price of prescription for Third Party Transactions - Average ACQ Cost of prescription for Cash Transactions))"
      type: number
      sql: (${avg_price_tp} - ${avg_acquisition_cost_tp}) ;;
      value_format: "$#,##0.00;($#,##0.00)"
    }

    measure: avg_uc_price {
      label: "Avg Prescription U&C Price"
      description: "Average Usual and Customary Price of the prescription of the drug filled"
      type: average
      sql: ${TABLE}.RX_TX_UC_PRICE ;;
      value_format: "$#,##0.00;($#,##0.00)"
    }

    measure: avg_other_price {
      label: "Avg Prescription Other Price"
      description: "Average price of the other drug (brand/generic) that was not used in the dispensing of this prescription"
      type: average
      sql: (CASE WHEN ${TABLE}.LAST_YEAR = 'No' THEN ${TABLE}.RX_TX_OTHER_PRICE END) ;;
      value_format: "$#,##0.00;($#,##0.00)"
    }

    measure: autofill_decimal_qty {
      #       This column has all values null (as of 15th April 2016)
      hidden: yes
      label: "Prescription Autofill Decimal Qty"
      description: "The autofill prescription refill quantity in decimals"
      type: number
      sql: (CASE WHEN ${TABLE}.LAST_YEAR = 'No' THEN ${TABLE}.RX_TX_AUTOFILL_DECIMAL_QTY END) ;;
      value_format: "#,##0.00"
    }

    measure: sum_autofill_quantity {
      label: "Total Prescription Autofill Quantity"
      description: "Total autofill prescription refill quantity"
      type: sum
      sql: (CASE WHEN ${TABLE}.LAST_YEAR = 'No' THEN ${TABLE}.RX_TX_AUTOFILL_QUANTITY END) ;;
      value_format: "#,##0.00;(#,##0.00)"
    }

    measure: avg_autofill_quantity {
      label: "Avg Prescription Autofill Quantity"
      description: "Average autofill prescription refill quantity"
      type: average
      sql: (CASE WHEN ${TABLE}.LAST_YEAR = 'No' THEN ${TABLE}.RX_TX_AUTOFILL_QUANTITY END) ;;
      value_format: "#,##0.00;(#,##0.00)"
    }

    measure: sum_compound_fee {
      label: "Total Prescription Compound Fee"
      description: "Total compound preparation charges"
      type: sum
      sql: (CASE WHEN ${TABLE}.LAST_YEAR = 'No' THEN ${TABLE}.RX_TX_COMPOUND_FEE END) ;;
      value_format: "$#,##0.00;($#,##0.00)"
    }

    measure: avg_compound_fee {
      label: "Avg Prescription Compound Fee"
      description: "Average compound preparation charges"
      type: average
      sql: (CASE WHEN ${TABLE}.LAST_YEAR = 'No' THEN ${TABLE}.RX_TX_COMPOUND_FEE END) ;;
      value_format: "$#,##0.00;($#,##0.00)"
    }

    measure: sum_owed_quantity {
      label: "Total Prescription Owed Quantity"
      description: "OWED stores the number of units (quantity) of the drug that are owed to the patient"
      type: sum
      sql: (CASE WHEN ${TABLE}.LAST_YEAR = 'No' THEN ${TABLE}.RX_TX_OWED_QUANTITY END) ;;
      value_format: "#,##0.00;(#,##0.00)"
    }

    measure: sum_prescribed_decimal_qty {
      #       This column has all values null (as of 15th April 2016)
      hidden: yes
      label: "Total Prescription Prescribed Decimal Quantity"
      description: "Total Decimal quantity for prescribed prescription quantity"
      type: sum
      sql: (CASE WHEN ${TABLE}.LAST_YEAR = 'No' THEN ${TABLE}.RX_TX_PRESCRIBED_DECIMAL_QTY END) ;;
      value_format: "#,##0.00"
    }

    measure: avg_prescribed_decimal_qty {
      #       This column has all values null (as of 15th April 2016)
      hidden: yes
      label: "Avg Prescription Prescribed Decimal Quantity"
      description: "Average Decimal quantity for prescribed prescription quantity"
      type: average
      sql: (CASE WHEN ${TABLE}.LAST_YEAR = 'No' THEN ${TABLE}.RX_TX_PRESCRIBED_DECIMAL_QTY END) ;;
      value_format: "#,##0.00"
    }

    measure: sum_tax {
      label: "Total Prescription Tax"
      description: "Total Sales tax amount of the drug filled"
      type: sum
      sql: ${TABLE}.RX_TX_TAX_AMOUNT ;;
      value_format: "$#,##0.00;($#,##0.00)"
    }

    measure: avg_tax {
      label: "Avg Prescription Tax"
      description: "Average Sales tax amount of the drug filled"
      type: average
      sql: ${TABLE}.RX_TX_TAX_AMOUNT ;;
      value_format: "$#,##0.00;($#,##0.00)"
    }

    measure: sum_discount {
      label: "Total Prescription Discount"
      description: "Total Patient's discount based on drug dispensed(Brand/Generic)"
      type: sum
      sql: ${TABLE}.RX_TX_DISCOUNT_AMOUNT ;;
      value_format: "$#,##0.00;($#,##0.00)"
    }

    measure: avg_discount {
      label: "Avg Prescription Discount"
      description: "Average Patient's discount based on drug dispensed(Brand/Generic)"
      type: average
      sql: ${TABLE}.RX_TX_DISCOUNT_AMOUNT ;;
      value_format: "$#,##0.00;($#,##0.00)"
    }

    measure: sum_fill_quantity {
      label: "Total Prescription Fill Quantity"
      description: "Total Quantity (number of units) of the drug you dispensed"
      type: sum
      sql: ${TABLE}.RX_TX_FILL_QUANTITY ;;
      value_format: "#,##0.00;(#,##0.00)"
    }

    measure: avg_fill_quantity {
      label: "Avg Prescription Fill Quantity"
      description: "Average Quantity (number of units) of the drug you dispensed"
      type: average
      sql: ${TABLE}.RX_TX_FILL_QUANTITY ;;
      value_format: "#,##0.00;(#,##0.00)"
    }

    measure: sum_quantity {
      label: "Total Prescription Quantity"
      description: "Total prescription transaction prescribed refill quantity"
      type: sum
      sql: ${TABLE}.RX_TX_QUANTITY ;;
      value_format: "#,##0.00;(#,##0.00)"
    }

    measure: avg_quantity {
      label: "Avg Prescription Quantity"
      description: "Average prescription transaction prescribed refill quantity"
      type: average
      sql: ${TABLE}.RX_TX_QUANTITY ;;
      value_format: "#,##0.00;(#,##0.00)"
    }

    measure: sum_remaining_quantity {
      label: "Total Prescription Remaining Quantity"
      description: "Total number of remaining units (quantity) of the drug for this prescription"
      type: sum
      sql: ${TABLE}.RX_TX_REMAINING_QUANTITY ;;
      value_format: "#,##0.00;(#,##0.00)"
    }

    measure: avg_remaining_quantity {
      label: "Avg Prescription Remaining Quantity"
      description: "Average number of remaining units (quantity) of the drug for this prescription"
      type: average
      sql: ${TABLE}.RX_TX_REMAINING_QUANTITY ;;
      value_format: "#,##0.00;(#,##0.00)"
    }

    measure: sum_cost {
      #       This column is hidden to avoid confusion around prescription cost and prescription acquistion cost and prescription acquisition cost is what is required for now based on drug dispensed (Brand/Generic)
      hidden: yes
      label: "Total Prescription Cost"
      description: "Total dollar amount the cost was for this transaction of the drug filled"
      type: sum
      sql: ${TABLE}.RX_TX_COST ;;
      value_format: "$#,##0.00;($#,##0.00)"
    }

    measure: avg_cost {
      #       This column is hidden to avoid confusion around prescription cost and prescription acquistion cost and prescription acquisition cost is what is required for now based on drug dispensed (Brand/Generic)
      hidden: yes
      label: "Avg Prescription Cost"
      description: "Average dollar amount the cost was for this transaction of the drug filled"
      type: average
      sql: ${TABLE}.RX_TX_COST ;;
      value_format: "$#,##0.00;($#,##0.00)"
    }

    ############################################################ Templated Filters (Applied only for measures (so it could be applied in WHERE instead of HAVING clause #################################
    filter: cost_filter {
      #       This column is hidden to avoid confusion around prescription cost and prescription acquistion cost and prescription acquisition cost is what is required for now based on drug dispensed (Brand/Generic)
      hidden: yes
      label: "Prescription Cost"
      description: "Dollar amount the cost was for this transaction of the drug filled"
      type: number
    }

    filter: acquisition_cost_filter {
      label: "Prescription Acquisition Cost"
      description: "Acquisition cost of filled drug used on the prescription transaction record"
      type: number
    }

    filter: autofill_quantity_filter {
      label: "Prescription Autofill Quantity"
      description: "Autofill prescription refill quantity"
      type: number
    }

    filter: other_price_filter {
      label: "Prescription Other Price"
      description: "Price of the other drug (brand/generic) that was not used in the dispensing of this prescription"
      type: number
    }

    filter: price_filter {
      label: "Prescription Price"
      description: "Price of prescription"
      type: number
    }

    filter: fill_quantity_filter {
      label: "Prescription Fill Quantity"
      description: "Quantity (number of units) of the drug you dispensed"
      type: number
    }

    filter: quantity_filter {
      label: "Prescription Quantity"
      description: "Prescription transaction prescribed refill quantity"
      type: number
    }

    filter: gross_margin_filter {
      label: "Prescription Gross Margin Dollars"
      description: "Margin Dollars of the Filled Prescription. Formula Used: ( (Total Price of prescription - Total Acquisition Cost of prescription))"
      type: number
    }

    filter: sold_date_filter {
      label: "Prescription Sold Date \"Filter Only\""
      description: "Date/Time prescription was sold"
      type: date
    }

    filter: reportable_sales_date_filter {
      label: "Prescription Reportable Sales Date \"Filter Only\""
      description: "Used to record the date when a TP script was adjudicated. For cash scripts, it is set when DE is completed"
      type: date
    }

    filter: filled_date_filter {
      label: "Prescription Filled Date \"Filter Only\""
      description: "Date prescription was filled"
      type: date
    }

    filter: this_year_last_year_filter {
      label: "Prescription TY/LY Analysis (Yes/No)"
      description: "Flag that indicates if LY vs. TY Analysis is required on selected measures. Use 'Yes-Filled' if LY Analysis is required based on filled date, 'Yes-Sold' if LY Analysis is required on sold date and 'Yes-ReportableSales', if LY Analysis is required on Reportable Sales Date. By Default a value of 'No' would be selected"
      type: string
      suggestions: ["No", "Yes-Sold", "Yes-Filled", "Yes-ReportableSales"]
      full_suggestions: yes
    }

    ###############################################################################################################################################################################################

    set: detail {
      fields: [
        bi_demo_chain.chain_name,
        bi_demo_region.division,
        bi_demo_region.region,
        bi_demo_region.district,
        bi_demo_store.store_number,
        bi_demo_store.store_name,
        drug.drug_name,

        #added by KR on 7-25-16
        filled,
        sold_date,
        tx_number,

        #added by JCF on 7-21-16
        ndc,

        #added by JCF on 7-21-16
        ncpdp_daw,

        #added by KR on 08-02-16
        paid_at_uc,

        #added by KR on 08-02-16
        sum_uc_price,

        #added by JCF on 7-21-16
        sum_price,

        #added by JCF on 7-21-16
        sum_acquisition_cost,

        #added by JCF on 7-21-16
        sum_margin_dollars
      ]
    }

    #Grouping Will Call Picked Up Date Into sets, hence whenever all the fiels/parameters in this dimension group needs to be used, the set can be used.
    set: will_call_picked_up_date_info {
      fields: [
        will_call_picked_up_time,
        will_call_picked_up_date,
        will_call_picked_up_week,
        will_call_picked_up_month,
        will_call_picked_up_month_num,
        will_call_picked_up_year,
        will_call_picked_up_quarter,
        will_call_picked_up_quarter_of_year,
        will_call_picked_up_hour_of_day,
        will_call_picked_up_time_of_day,
        will_call_picked_up_hour2,
        will_call_picked_up_minute15,
        will_call_picked_up_day_of_week,
        will_call_picked_up_week_of_year,
        will_call_picked_up_day_of_week_index,
        will_call_picked_up_day_of_month
      ]
    }

    set: rx_tx_claim_info {
      fields: [
        refill_number,
        tx_number,
        call_for_refills,
        compound,
        filled_date,
        filled_week,
        filled_month,
        filled_month_num,
        filled_year,
        filled_quarter,
        filled_quarter_of_year,
        filled,
        filled_day_of_week,
        filled_day_of_month,
        first_filled_date,
        first_filled_week,
        first_filled_month,
        first_filled_month_num,
        first_filled_year,
        first_filled_quarter,
        first_filled_quarter_of_year,
        first_filled,
        first_filled_day_of_week,
        first_filled_day_of_month,
        has_compound_ingredients,
        immunization_indicator_description,
        original_written_date,
        original_written_week,
        original_written_month,
        original_written_month_num,
        original_written_year,
        original_written_quarter,
        original_written_quarter_of_year,
        original_written,
        original_written_day_of_week,
        original_written_day_of_month,
        partial_fill_status,
        rx_start_date,
        rx_start_week,
        rx_start_month,
        rx_start_month_num,
        rx_start_year,
        rx_start_quarter,
        rx_start_quarter_of_year,
        rx_start,
        rx_start_day_of_week,
        rx_start_day_of_month,
        rx_status,
        sold_date,
        sold_week,
        sold_month,
        sold_month_num,
        sold_year,
        sold_quarter,
        sold_quarter_of_year,
        sold,
        sold_day_of_week,
        sold_day_of_month,
        transfer,
        tx_status,
        usual_and_customary_pricing_flag,
        written_date,
        written_week,
        written_month,
        written_month_num,
        written_year,
        written_quarter,
        written_quarter_of_year,
        written,
        written_day_of_week,
        written_day_of_month,
        count,
        sum_cost,
        sum_acquisition_cost,
        sum_autofill_quantity,
        sum_compound_fee,
        sum_other_price,
        sum_prescribed_decimal_qty,
        sum_margin,
        sum_margin_dollars,
        sum_price,
        sum_fill_quantity,
        sum_quantity,
        sum_remaining_quantity,
        cost_filter,
        acquisition_cost_filter,
        autofill_quantity_filter,
        fill_quantity_filter,
        quantity_filter,
        price_filter,
        gross_margin_filter,
        sold_date_filter,
        reportable_sales_date_filter,
        filled_date_filter,
        this_year_last_year_filter
      ]
    }
  }

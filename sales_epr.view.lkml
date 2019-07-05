view: sales_epr {
  derived_table: {
    sql: WITH EPR_RXTX AS
          ( SELECT
             SALES.CHAIN_ID,
             SALES.NHIN_STORE_ID,
             SALES.RX_COM_ID,
             SALES.RX_TX_DISPENSED_DRUG_NDC,
             SALES.RX_TX_RX_NUMBER,
             SALES.RX_TX_TX_NUMBER,
             SALES.RX_TX_REFILL_NUMBER,
             SALES.PLAN,
             SALES.RX_TX_RETURNED_DATE,
             COALESCE((CASE WHEN SALES.TX_TP_SPLIT_BILL_FLAG = 'Y' then COALESCE(SALES.NET_DUE, 0)
                     ELSE COALESCE(SALES.NET_DUE, 0) + COALESCE(SALES.FINAL_COPAY, 0)
                     END),0) AS NET_SALES,
             SALES.RX_TX_PRICE,
             SALES.RX_TX_DISCOUNT_AMOUNT,
             SALES.SPLIT_PRICE,
             SALES.RX_TX_TAX_AMOUNT,
             SALES.WRITE_OFF,
             SALES.COUNTER,
             SALES.FIRST_COUNTER,
             SALES.TX_TP_SPLIT_BILL_FLAG,
             SALES.FINAL_COPAY,
             SALES.RX_TX_ACQUISITION_COST,
             SALES.SUBMIT_TYPE,
             SALES.RX_TX_REPORTABLE_SALES_DATE,
             SALES.RX_TX_FILLED_DATE,
             SALES.RX_TX_SOLD_DATE,
             SALES.NET_DUE,
             SALES.NET_PAID,
             COALESCE((CASE WHEN SALES.TX_TP_SPLIT_BILL_FLAG = 'Y' then 0
                     ELSE COALESCE(SALES.FINAL_COPAY, 0)
                     END),0) AS PATIENT_PAY_AMOUNT,
             CASE
                      WHEN SALES.PLAN = 'CASH' AND SALES.RX_TX_RETURNED_DATE IS NULL THEN 'CASH - FILLED'
                      WHEN SALES.PLAN <> 'CASH' AND SALES.RX_TX_RETURNED_DATE IS NULL  THEN 'T/P - FILLED'
                      WHEN SALES.PLAN = 'CASH' AND SALES.RX_TX_RETURNED_DATE IS NOT NULL  THEN 'CASH - CREDIT'
                      WHEN SALES.PLAN <> 'CASH' AND SALES.RX_TX_RETURNED_DATE IS NULL  THEN 'T/P - CREDIT'
             END AS NO_HISTORY_FINANCIAL_CATEGORY,
             CASE
                      WHEN {% condition history_filter %} 'YES' {% endcondition %} AND {% condition date_to_use_filter %} 'REPORTABLE SALES' {% endcondition %}
                        THEN
                          CASE
                            WHEN {% condition sales_date_filter %} SALES.RX_TX_REPORTABLE_SALES_DATE {% endcondition %} AND
                                  SALES.PLAN <> 'CASH' AND
                                  (SALES.RX_TX_RETURNED_DATE IS NULL OR
                                  TO_DATE(SALES.RX_TX_REPORTABLE_SALES_DATE) <> TO_DATE(SALES.RX_TX_RETURNED_DATE)) THEN 'T/P - FILLED'
                            WHEN {% condition sales_date_filter %} SALES.RX_TX_REPORTABLE_SALES_DATE {% endcondition %} AND
                                  SALES.PLAN = 'CASH' AND
                                  (SALES.RX_TX_RETURNED_DATE IS NULL OR
                                  TO_DATE(SALES.RX_TX_REPORTABLE_SALES_DATE) <> TO_DATE(SALES.RX_TX_RETURNED_DATE)) THEN 'CASH - FILLED'
                          END
                      WHEN {% condition history_filter %} 'YES' {% endcondition %} AND {% condition date_to_use_filter %} 'SOLD' {% endcondition %}
                        THEN
                          CASE
                            WHEN {% condition sales_date_filter %} SALES.RX_TX_SOLD_DATE {% endcondition %} AND
                                  SALES.PLAN <> 'CASH' AND
                                  (SALES.RX_TX_RETURNED_DATE IS NULL OR
                                  TO_DATE(SALES.RX_TX_SOLD_DATE) <> TO_DATE(SALES.RX_TX_RETURNED_DATE)) THEN 'T/P - FILLED'
                            WHEN {% condition sales_date_filter %} SALES.RX_TX_SOLD_DATE {% endcondition %} AND
                                  SALES.PLAN = 'CASH' AND
                                  (SALES.RX_TX_RETURNED_DATE IS NULL OR
                                  TO_DATE(SALES.RX_TX_SOLD_DATE) <> TO_DATE(SALES.RX_TX_RETURNED_DATE)) THEN 'CASH - FILLED'
                          END
                    END SALE,
                    CASE
                      WHEN {% condition history_filter %} 'YES' {% endcondition %} AND {% condition date_to_use_filter %} 'REPORTABLE SALES' {% endcondition %}
                        THEN
                          CASE
                            WHEN {% condition sales_date_filter %} SALES.RX_TX_RETURNED_DATE {% endcondition %} AND
                                  SALES.PLAN <> 'CASH' AND
                                  (SALES.RX_TX_RETURNED_DATE IS NOT NULL AND
                                  TO_DATE(SALES.RX_TX_REPORTABLE_SALES_DATE) <> TO_DATE(SALES.RX_TX_RETURNED_DATE)) THEN 'T/P - CREDIT'
                            WHEN {% condition sales_date_filter %} SALES.RX_TX_RETURNED_DATE {% endcondition %} AND
                                  SALES.PLAN = 'CASH' AND
                                  (SALES.RX_TX_RETURNED_DATE IS NOT NULL AND
                                  TO_DATE(SALES.RX_TX_REPORTABLE_SALES_DATE) <> TO_DATE(SALES.RX_TX_RETURNED_DATE)) THEN 'CASH - CREDIT'
                          END
                      WHEN {% condition history_filter %} 'YES' {% endcondition %} AND {% condition date_to_use_filter %} 'SOLD' {% endcondition %}
                        THEN
                          CASE
                            WHEN {% condition sales_date_filter %} SALES.RX_TX_RETURNED_DATE {% endcondition %} AND
                                  SALES.PLAN <> 'CASH' AND
                                  (SALES.RX_TX_RETURNED_DATE IS NOT NULL AND
                                  TO_DATE(SALES.RX_TX_SOLD_DATE) <> TO_DATE(SALES.RX_TX_RETURNED_DATE)) THEN 'T/P - CREDIT'
                            WHEN {% condition sales_date_filter %} SALES.RX_TX_RETURNED_DATE {% endcondition %} AND
                                  SALES.PLAN = 'CASH' AND
                                  (SALES.RX_TX_RETURNED_DATE IS NOT NULL AND
                                  TO_DATE(SALES.RX_TX_SOLD_DATE) <> TO_DATE(SALES.RX_TX_RETURNED_DATE)) THEN 'CASH - CREDIT'
                          END
                    END CREDIT
                      FROM
                      (
                      SELECT
                             SASD.CHAIN_ID,
                             SASD.NHIN_STORE_ID,
                             SASD.RX_COM_ID,
                             SASD.RX_TX_DISPENSED_DRUG_NDC,
                             SASD.RX_TX_RX_NUMBER,
                             SASD.RX_TX_TX_NUMBER,
                             SASD.RX_TX_REFILL_NUMBER,
                             SASD.PLAN,
                             SASD.RX_TX_RETURNED_DATE,
                             SASD.RX_TX_PRICE,
                             SASD.RX_TX_DISCOUNT_AMOUNT,
                             SASD.SPLIT_PRICE,
                             SASD.RX_TX_TAX_AMOUNT,
                             SASD.WRITE_OFF,
                             SASD.COUNTER,
                             MIN(NVL(SASD.COUNTER,-1)) OVER (PARTITION BY SASD.CHAIN_ID,SASD.NHIN_STORE_ID,SASD.RX_TX_TX_NUMBER ORDER BY COUNTER ASC NULLS FIRST) as FIRST_COUNTER,
                             SASD.TX_TP_SPLIT_BILL_FLAG,
                             SASD.FINAL_COPAY,
                             SASD.RX_TX_ACQUISITION_COST,
                             SASD.SUBMIT_TYPE,
                             SASD.RX_TX_REPORTABLE_SALES_DATE,
                             SASD.RX_TX_FILLED_DATE,
                             SASD.RX_TX_SOLD_DATE,
                             SASD.NET_DUE,
                             SASD.NET_PAID,
                             ROW_NUMBER() OVER (PARTITION BY SASD.CHAIN_ID,SASD.NHIN_STORE_ID,SASD.RX_TX_TX_NUMBER ORDER BY SASD.RX_TX_FILLED_DATE DESC) AS RANK_TO_PICK_CORRECT_RX_TX_WHEN_DUPLICATED_IN_EPR

                      FROM
                      (
                                    SELECT
                                              EPR.CHAIN_ID,
                                              EPR.NHIN_STORE_ID,
                                              EPR.RX_COM_ID,
                                              EPR.RX_TX_DISPENSED_DRUG_NDC,
                                              EPR.RX_TX_RX_NUMBER,
                                              EPR.RX_TX_TX_NUMBER,
                                             'CASH' AS PLAN,
                                              DECODE(EPS.NHIN_STORE_ID,NULL,NVL(EPRCRED.RX_TX_CRED_REVERSED_DATE,EPRCRED.RX_TX_CRED_RETURNED_DATE),EPS.RX_TX_RETURNED_DATE) AS RX_TX_RETURNED_DATE,
                                              DECODE(EPS.NHIN_STORE_ID,NULL,EPR.RX_TX_PRICE,EPS.PRICE) AS RX_TX_PRICE,
                                              DECODE(EPS.NHIN_STORE_ID,NULL,EPR.RX_TX_DISCOUNT_AMOUNT,EPS.DISCOUNT) AS RX_TX_DISCOUNT_AMOUNT,
                                              0 AS SPLIT_PRICE,
                                              DECODE(EPS.NHIN_STORE_ID,NULL,EPR.RX_TX_TAX_AMOUNT,EPS.RX_TX_TAX_AMOUNT) AS RX_TX_TAX_AMOUNT,
                                              0 AS WRITE_OFF,
                                              0 AS COUNTER,
                                              'N' AS TX_TP_SPLIT_BILL_FLAG,
                                              0 AS FINAL_COPAY,
                                              DECODE(EPS.NHIN_STORE_ID,NULL,EPR.RX_TX_ACQUISITION_COST,EPS.ACQUISITION_COST) AS RX_TX_ACQUISITION_COST,
                                              NULL AS SUBMIT_TYPE,
                                              DECODE(EPS.NHIN_STORE_ID,NULL,EPR.RX_TX_REFILL_NUMBER,EPS.RX_TX_REFILL_NUMBER) AS RX_TX_REFILL_NUMBER,
                                              DECODE(EPS.NHIN_STORE_ID,NULL,DECODE(EPR.RX_TX_REPORTABLE_SALES_DATE,NULL,EPR.RX_TX_FILLED_DATE),EPS.RX_TX_REPORTABLE_SALES_DATE) AS RX_TX_REPORTABLE_SALES_DATE,
                                              DECODE(EPS.NHIN_STORE_ID,NULL,EPR.RX_TX_FILLED_DATE,EPS.RX_TX_FILL_DATE) AS RX_TX_FILLED_DATE,
                                              DECODE(EPS.NHIN_STORE_ID,NULL,EPR.RX_TX_SOLD_DATE,EPS.RX_TX_WILL_CALL_PICKED_UP_DATE) AS RX_TX_SOLD_DATE,
                                              0 AS NET_DUE,
                                              DECODE(EPS.NHIN_STORE_ID,NULL,EPR.RX_TX_POS_OVERRIDDEN_NET_PAID,EPS.RX_TX_POS_OVERRIDDEN_NET_PAID) AS NET_PAID,
                                              DECODE(EPS.NHIN_STORE_ID,NULL,EPR.RX_TX_TP_BILL,EPS.RX_TX_TP_BILL) AS RX_TX_TP_BILL,
                                              DECODE(EPS.NHIN_STORE_ID,NULL,EPR.RX_TX_RX_STATUS,EPS.RX_STATUS) AS RX_TX_RX_STATUS,
                                              DECODE(EPS.NHIN_STORE_ID,NULL,EPR.RX_TX_TX_STATUS,EPS.RX_TX_TX_STATUS) AS RX_TX_TX_STATUS,
                                              DECODE(EPS.NHIN_STORE_ID,NULL,EPR.RX_TX_FILL_STATUS,EPS.RX_TX_FILL_STATUS) AS RX_TX_FILL_STATUS
                                    FROM EDW.F_RX_TX EPR    -- Encompasses PDX Classic and EPS Non-Symmetric Stores
                                    INNER JOIN  EDW.D_PATIENT PT
                                    ON ( EPR.CHAIN_ID = PT.CHAIN_ID AND
                                         EPR.RX_COM_ID = PT.RX_COM_ID
                                       )
                  LEFT OUTER JOIN EDW.F_RX_TX_CRED EPRCRED
                  ON EPR.CHAIN_ID = EPRCRED.CHAIN_ID
                  AND EPR.RX_TX_ID = EPRCRED.RX_TX_ID
                                    LEFT OUTER JOIN
                                     ( SELECT
                                    TX.CHAIN_ID,
                                    TX.NHIN_STORE_ID,
                                    RX.RX_NUMBER,
                                    TX.RX_TX_TX_NUMBER,
                                    RX.RX_STATUS,
                                    TX.RX_TX_TX_STATUS,
                                    TX.RX_TX_PARTIAL_FILL_STATUS,
                                    TX.RX_TX_FILL_STATUS,
                                    TX.RX_TX_POS_STATUS,
                                    TX.RX_TX_DRUG_DISPENSED,
                                    DECODE(TX.RX_TX_RETURNED_DATE,NULL,DECODE(TX.RX_TX_DRUG_DISPENSED,'G',NVL(TX.RX_TX_GENERIC_PRICE,0),NVL(TX.RX_TX_BRAND_PRICE,0)),NVL(TX.RX_TX_ORIGINAL_PRICE,0)) AS PRICE,
                                    DECODE(TX.RX_TX_DRUG_DISPENSED,'G',NVL(TX.RX_TX_GENERIC_ACQUISITION_COST,0),NVL(TX.RX_TX_BRAND_ACQUISITION_COST,0)) AS ACQUISITION_COST,
                                    TX.RX_TX_REPORTABLE_SALES_DATE,
                                    TX.RX_TX_RETURNED_DATE,
                                    TX.RX_TX_POS_OVERRIDDEN_NET_PAID,
                                    DECODE(TX.RX_TX_DRUG_DISPENSED,'G',NVL(TX.RX_TX_GENERIC_DISCOUNT, 0),NVL(TX.RX_TX_BRAND_DISCOUNT, 0)) AS DISCOUNT,
                                    TX.RX_TX_TAX_AMOUNT,
                                    TX.RX_TX_TP_BILL,
                                    TX.RX_TX_REFILL_NUMBER,
                                    TX.RX_TX_FILL_DATE,
                                    TX.RX_TX_WILL_CALL_PICKED_UP_DATE,
                                    TX.RX_TX_DELETED,
                                    RX.RX_DELETED,
                                    RX.SOURCE_TIMESTAMP AS RX_SOURCE_TIMESTAMP,
                                    TX.SOURCE_TIMESTAMP AS RX_TX_SOURCE_TIMESTAMP
                                    FROM EDW.F_RX_TX_LINK TX
                                    INNER JOIN EDW.F_RX RX
                                    ON (  RX.CHAIN_ID = TX.CHAIN_ID AND
                                        RX.NHIN_STORE_ID = TX.NHIN_STORE_ID AND
                                        RX.RX_ID = TX.RX_ID)
                                    WHERE {% condition chain.chain_id %} TX.CHAIN_ID {% endcondition %}   -- Required for performance reasons and to avoid scanning all chain/store records
                                      AND {% condition store.nhin_store_id %} TX.NHIN_STORE_ID {% endcondition %}  -- Required for performance reasons and to avoid scanning all chain/store records
                                      -- [ERXDWPS-1690] Added store_number filter to avoid scanning all chain/store records and minimize data buffer for derived view.
                                      AND tx.nhin_store_id in (select distinct nhin_store_id from edw.d_store
                                                                where source_system_id = 5
                                                                  and {% condition chain.chain_id %} chain_id {% endcondition %}
                                                                  and {% condition store.store_number %} store_number {% endcondition %})
                                      AND {% condition chain.chain_id %} RX.CHAIN_ID {% endcondition %}   -- Required for performance reasons and to avoid scanning all chain/store records
                                      AND {% condition store.nhin_store_id %} RX.NHIN_STORE_ID {% endcondition %}  -- Required for performance reasons and to avoid scanning all chain/store records
                                      -- [ERXDWPS-1690] Added store_number filter to avoid scanning all chain/store records and minimize data buffer for derived view.
                                      AND rx.nhin_store_id in (select distinct nhin_store_id from edw.d_store
                                                                where source_system_id = 5
                                                                  and {% condition chain.chain_id %} chain_id {% endcondition %}
                                                                  and {% condition store.store_number %} store_number {% endcondition %})
                                      AND TX.SOURCE_SYSTEM_ID = 4 --ERXLPS-2547
                                      AND RX.SOURCE_SYSTEM_ID = 4 --ERXLPS-2547
                                    ) EPS
                                    ON (
                                                 EPR.CHAIN_ID = EPS.CHAIN_ID AND
                                                 EPR.NHIN_STORE_ID = EPS.NHIN_STORE_ID AND
                                                 EPR.RX_TX_RX_NUMBER = EPS.RX_NUMBER AND
                                                EPR.RX_TX_TX_NUMBER = EPS.RX_TX_TX_NUMBER
                                      )
                                      WHERE  {% condition chain.chain_id %} EPR.CHAIN_ID {% endcondition %} AND  -- Required for performance reasons and to avoid scanning all chain/store records
                                      {% condition store.nhin_store_id %} EPR.NHIN_STORE_ID {% endcondition %} AND -- Required for performance reasons and to avoid scanning all chain/store records
                                      -- [ERXDWPS-1690] Added store_number filter to avoid scanning all chain/store records and minimize data buffer for derived view.
                                      epr.nhin_store_id in (select distinct nhin_store_id from edw.d_store
                                                              where source_system_id = 5
                                                                and {% condition chain.chain_id %} chain_id {% endcondition %}
                                                                and {% condition store.store_number %} store_number {% endcondition %}) AND
                                      {% condition chain.chain_id %} PT.CHAIN_ID {% endcondition %} AND -- Required for performance reasons and to avoid scanning all chain/store records
                                      EPR.RX_TX_RX_DELETED = 'N' AND
                                      EPR.RX_TX_TX_DELETED = 'N' AND
                                      PT.PATIENT_SURVIVOR_ID IS NULL AND
                                      PT.PATIENT_UNMERGED_DATE IS NULL AND
                                      ( {% condition cash_filter %} 'CASH' {% endcondition %} OR {% condition cash_filter %} 'BOTH' {% endcondition %} )
                      ) SASD
                      WHERE
                        SASD.RX_TX_FILL_STATUS IS NOT NULL AND
                       (SASD.RX_TX_TP_BILL <> 'Y' OR SASD.RX_TX_TP_BILL IS NULL) AND
                       (SASD.RX_TX_RETURNED_DATE IS NOT NULL OR SASD.RX_TX_TX_STATUS IS NULL OR SASD.RX_TX_TX_STATUS <> 'H') AND
                       SASD.RX_TX_REPORTABLE_SALES_DATE IS NOT NULL

                       AND
                       (
                         (
                         {% condition date_to_use_filter %} 'REPORTABLE SALES' {% endcondition %}
                         AND
                         (SASD.RX_TX_RETURNED_DATE IS NULL OR TO_DATE(SASD.RX_TX_REPORTABLE_SALES_DATE) <> TO_DATE(SASD.RX_TX_RETURNED_DATE) ) AND
                         (
                               (
                                     SASD.RX_TX_RETURNED_DATE IS NULL AND
                                     {% condition sales_date_filter %} SASD.RX_TX_REPORTABLE_SALES_DATE {% endcondition %}
                                     -- AND SASD.RX_TX_REPORTABLE_SALES_DATE BETWEEN TO_TIMESTAMP('2016-06-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS') AND TO_TIMESTAMP('2016-06-30 23:59:59', 'YYYY-MM-DD HH24:MI:SS')
                               )
                              OR
                              (
                                     SASD.RX_TX_RETURNED_DATE IS NOT NULL AND
                                      (
                                           (
                                                 {% condition sales_date_filter %} SASD.RX_TX_RETURNED_DATE {% endcondition %}
                                                  -- AND SASD.RX_TX_RETURNED_DATE BETWEEN TO_TIMESTAMP('2016-06-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS') AND TO_TIMESTAMP('2016-06-30 23:59:59', 'YYYY-MM-DD HH24:MI:SS')
                                           )
                                            OR
                                            (
                                                 {% condition history_filter %} 'YES' {% endcondition %} AND
                                                 {% condition sales_date_filter %} SASD.RX_TX_REPORTABLE_SALES_DATE {% endcondition %} AND
                                                  -- SASD.RX_TX_REPORTABLE_SALES_DATE BETWEEN TO_TIMESTAMP('2016-06-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS') AND TO_TIMESTAMP('2016-06-30 23:59:59', 'YYYY-MM-DD HH24:MI:SS') AND
                                                  SASD.RX_TX_RETURNED_DATE > ( SELECT MAX(CALENDAR_DATE) -- Includes future date credit return TXs
                                                                                    FROM
                                                                                    ( SELECT TO_DATE(DATEADD(DAY,SEQ4(),TRUNC(TO_DATE(TO_TIMESTAMP('2014-01-01 12:00:00')),'DAY'))) AS CALENDAR_DATE
                                                                                    FROM TABLE(GENERATOR(rowCount => 5112)) )
                                                                                    WHERE {% condition sales_date_filter %} CALENDAR_DATE {% endcondition %}
                                                                              )
                                                 -- SASD.RX_TX_RETURNED_DATE > TO_TIMESTAMP('2016-06-30 23:59:59', 'YYYY-MM-DD HH24:MI:SS')
                                            )
                                       )
                               )
                          )
                        )
                      OR
                        (
                         {% condition date_to_use_filter %} 'SOLD' {% endcondition %}
                         AND
                         (SASD.RX_TX_RETURNED_DATE IS NULL OR TO_DATE(SASD.RX_TX_SOLD_DATE) <> TO_DATE(SASD.RX_TX_RETURNED_DATE) ) AND
                         (
                               (
                                     SASD.RX_TX_RETURNED_DATE IS NULL AND
                                     {% condition sales_date_filter %} SASD.RX_TX_SOLD_DATE {% endcondition %}
                                     -- AND SASD.RX_TX_SOLD_DATE BETWEEN TO_TIMESTAMP('2016-06-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS') AND TO_TIMESTAMP('2016-06-30 23:59:59', 'YYYY-MM-DD HH24:MI:SS')
                               )
                              OR
                              (
                                     SASD.RX_TX_RETURNED_DATE IS NOT NULL AND
                                      (
                                           (
                                                 {% condition sales_date_filter %} SASD.RX_TX_RETURNED_DATE {% endcondition %}
                                                  -- AND SASD.RX_TX_RETURNED_DATE BETWEEN TO_TIMESTAMP('2016-06-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS') AND TO_TIMESTAMP('2016-06-30 23:59:59', 'YYYY-MM-DD HH24:MI:SS')
                                           )
                                            OR
                                            (
                                                 {% condition history_filter %} 'YES' {% endcondition %} AND
                                                 {% condition sales_date_filter %} SASD.RX_TX_SOLD_DATE {% endcondition %} AND
                                                  -- SASD.RX_TX_SOLD_DATE BETWEEN TO_TIMESTAMP('2016-06-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS') AND TO_TIMESTAMP('2016-06-30 23:59:59', 'YYYY-MM-DD HH24:MI:SS') AND
                                                  SASD.RX_TX_RETURNED_DATE > ( SELECT MAX(CALENDAR_DATE) -- Includes future date credit return TXs
                                                                                    FROM
                                                                                    ( SELECT TO_DATE(DATEADD(DAY,SEQ4(),TRUNC(TO_DATE(TO_TIMESTAMP('2014-01-01 12:00:00')),'DAY'))) AS CALENDAR_DATE
                                                                                    FROM TABLE(GENERATOR(rowCount => 5112)) )
                                                                                    WHERE {% condition sales_date_filter %} CALENDAR_DATE {% endcondition %}
                                                                              )
                                                 -- SASD.RX_TX_RETURNED_DATE > TO_TIMESTAMP('2016-06-30 23:59:59', 'YYYY-MM-DD HH24:MI:SS')
                                            )
                                       )
                               )
                          )
                        )
                      )

              UNION ALL

                SELECT
                       SASD.CHAIN_ID,
                       SASD.NHIN_STORE_ID,
                       SASD.RX_COM_ID,
                       SASD.RX_TX_DISPENSED_DRUG_NDC,
                       SASD.RX_TX_RX_NUMBER,
                       SASD.RX_TX_TX_NUMBER,
                       SASD.RX_TX_REFILL_NUMBER,
                       SASD.PLAN,
                       SASD.RX_TX_RETURNED_DATE,
                       SASD.RX_TX_PRICE,
                       SASD.RX_TX_DISCOUNT_AMOUNT,
                       SASD.SPLIT_PRICE,
                       SASD.RX_TX_TAX_AMOUNT,
                       SASD.WRITE_OFF,
                       SASD.COUNTER,
                       MIN(NVL(SASD.COUNTER,-1)) OVER (PARTITION BY SASD.CHAIN_ID,SASD.NHIN_STORE_ID,SASD.RX_TX_TX_NUMBER ORDER BY COUNTER ASC NULLS FIRST) as FIRST_COUNTER,
                       SASD.TX_TP_SPLIT_BILL_FLAG,
                       SASD.FINAL_COPAY,
                       SASD.RX_TX_ACQUISITION_COST,
                       SASD.TX_TP_SUBMIT_TYPE AS SUBMIT_TYPE,
                       SASD.RX_TX_SOLD_DATE,
                       SASD.RX_TX_FILLED_DATE,
                       SASD.RX_TX_SOLD_DATE,
                       SASD.NET_DUE,
                       SASD.NET_PAID,
                       ROW_NUMBER() OVER (PARTITION BY SASD.CHAIN_ID,SASD.NHIN_STORE_ID,SASD.RX_TX_TX_NUMBER,SASD.COUNTER ORDER BY SASD.RX_TX_FILLED_DATE DESC) AS RANK_TO_PICK_CORRECT_RX_TX_WHEN_DUPLICATED_IN_EPR
                FROM
                (
                SELECT
                    EPR.CHAIN_ID,
                    EPR.NHIN_STORE_ID,
                    EPR.RX_COM_ID,
                    EPR.RX_TX_DISPENSED_DRUG_NDC,
                    EPR.RX_TX_RX_NUMBER,
                    EPR.RX_TX_TX_NUMBER,
                    EPR.TX_TP_CARRIER_CODE AS PLAN,
                    DECODE(EPS.NHIN_STORE_ID,NULL,NVL(EPR.RX_TX_CRED_REVERSED_DATE,EPR.RX_TX_CRED_RETURNED_DATE),EPS.RX_TX_RETURNED_DATE) AS RX_TX_RETURNED_DATE,
                    DECODE(EPS.NHIN_STORE_ID,NULL,EPR.RX_TX_PRICE,EPS.PRICE) AS RX_TX_PRICE,
                    DECODE(EPS.NHIN_STORE_ID,NULL,EPR.RX_TX_DISCOUNT_AMOUNT,EPS.DISCOUNT) AS RX_TX_DISCOUNT_AMOUNT,
                    0 AS SPLIT_PRICE,
                    DECODE(EPS.NHIN_STORE_ID,NULL,EPR.RX_TX_TAX_AMOUNT,EPS.RX_TX_TAX_AMOUNT) AS RX_TX_TAX_AMOUNT,
                    DECODE(EPS.NHIN_STORE_ID,NULL,EPR.TX_TP_WRITE_OFF_AMOUNT,EPS.TX_TP_WRITE_OFF_AMOUNT) AS WRITE_OFF,
                    DECODE(EPS.NHIN_STORE_ID,NULL,EPR.TX_TP_COUNTER,EPS.TX_TP_COUNTER) AS COUNTER,
                    DECODE(EPS.NHIN_STORE_ID,NULL,EPR.TX_TP_SPLIT_BILL_FLAG,NULL) AS TX_TP_SPLIT_BILL_FLAG,
                    DECODE(EPS.NHIN_STORE_ID,NULL,EPR.TX_TP_FINAL_COPAY,EPS.TX_TP_FINAL_COPAY) AS FINAL_COPAY,
                    DECODE(EPS.NHIN_STORE_ID,NULL,EPR.RX_TX_ACQUISITION_COST,EPS.ACQUISITION_COST) AS RX_TX_ACQUISITION_COST,
                    DECODE(EPS.NHIN_STORE_ID,NULL,EPR.TX_TP_SUBMIT_TYPE,EPS.TX_TP_SUBMIT_TYPE) AS TX_TP_SUBMIT_TYPE,
                    DECODE(EPS.NHIN_STORE_ID,NULL,EPR.RX_TX_REFILL_NUMBER,EPS.RX_TX_REFILL_NUMBER) AS RX_TX_REFILL_NUMBER,
                    DECODE(EPS.NHIN_STORE_ID,NULL,DECODE(EPR.RX_TX_REPORTABLE_SALES_DATE,NULL,EPR.RX_TX_FILLED_DATE),EPS.RX_TX_REPORTABLE_SALES_DATE) AS RX_TX_REPORTABLE_SALES_DATE,
                    DECODE(EPS.NHIN_STORE_ID,NULL,EPR.RX_TX_FILLED_DATE,EPS.RX_TX_FILL_DATE) AS RX_TX_FILLED_DATE,
                    DECODE(EPS.NHIN_STORE_ID,NULL,EPR.RX_TX_SOLD_DATE,EPS.RX_TX_WILL_CALL_PICKED_UP_DATE) AS RX_TX_SOLD_DATE,
                    DECODE(EPS.NHIN_STORE_ID,NULL,EPR.TX_TP_BALANCE_DUE_FROM_TP,EPS.TX_TP_BALANCE_DUE_FROM_TP) AS NET_DUE,
                    DECODE(EPS.NHIN_STORE_ID,NULL,NVL(EPR.RX_TX_POS_OVERRIDDEN_NET_PAID,EPR.TX_TP_FINAL_COPAY),EPS.NETPAID) AS NET_PAID,
                    DECODE(EPS.NHIN_STORE_ID,NULL,EPR.TX_TP_FINAL_PRICE,EPS.TX_TP_FINAL_PRICE) AS TX_TP_FINAL_PRICE,
                    DECODE(EPS.NHIN_STORE_ID,NULL,EPR.RX_TX_TP_BILL,EPS.RX_TX_TP_BILL) AS RX_TX_TP_BILL,
                    DECODE(EPS.NHIN_STORE_ID,NULL,EPR.RX_TX_RX_STATUS,EPS.RX_STATUS) AS RX_TX_RX_STATUS,
                    DECODE(EPS.NHIN_STORE_ID,NULL,EPR.RX_TX_TX_STATUS,EPS.RX_TX_TX_STATUS) AS RX_TX_TX_STATUS,
                    DECODE(EPS.NHIN_STORE_ID,NULL,EPR.RX_TX_FILL_STATUS,EPS.RX_TX_FILL_STATUS) AS RX_TX_FILL_STATUS,
                    DECODE(EPS.NHIN_STORE_ID,NULL,EPR.TX_TP_PAID_STATUS,EPS.TX_TP_PAID_STATUS) AS TX_TP_PAID_STATUS,
                    DECODE(EPS.NHIN_STORE_ID,NULL,'N',NVL(EPS.TX_TP_INACTIVE,'N')) AS TX_TP_INACTIVE,
                    EPR.RX_TX_RX_DELETED,
                    EPR.RX_TX_TX_DELETED,
                    EPR.PATIENT_SURVIVOR_ID,
                    EPR.PATIENT_UNMERGED_DATE,
                    EPR.TX_TP_DELETED
                    FROM
                      (SELECT
                        EPR.CHAIN_ID,
                                EPR.NHIN_STORE_ID,
                                EPR.RX_TX_RX_NUMBER,
                                EPR.RX_TX_TX_NUMBER,
                                EPR.RX_TX_REFILL_NUMBER,
                                EPR.RX_TX_DISPENSED_DRUG_NDC,
                                EPR.RX_TX_RX_DELETED,
                                EPR.RX_TX_TX_DELETED,
                                EPR.RX_TX_PRICE,
                                EPR.RX_TX_DISCOUNT_AMOUNT,
                                 0 AS SPLIT_PRICE,
                                EPR.RX_TX_TAX_AMOUNT,
                                EPR.RX_TX_ACQUISITION_COST,
                                EPR.RX_TX_REPORTABLE_SALES_DATE,
                                EPR.RX_TX_FILLED_DATE,
                                EPR.RX_TX_SOLD_DATE,
                                EPR.RX_TX_POS_OVERRIDDEN_NET_PAID,
                                EPR.RX_TX_TP_BILL,
                                EPR.RX_TX_RX_STATUS,
                                EPR.RX_TX_TX_STATUS,
                                EPR.RX_TX_FILL_STATUS,
                                PT.RX_COM_ID,
                                PT.PATIENT_SURVIVOR_ID,
                                PT.PATIENT_UNMERGED_DATE,
                                EPRTXTP.TX_TP_CARRIER_CODE,
                                EPRTXTP.TX_TP_WRITE_OFF_AMOUNT,
                                EPRTXTP.TX_TP_COUNTER,
                                EPRTXTP.TX_TP_SPLIT_BILL_FLAG,
                                EPRTXTP.TX_TP_FINAL_COPAY,
                                EPRTXTP.TX_TP_SUBMIT_TYPE,
                                EPRTXTP.TX_TP_BALANCE_DUE_FROM_TP,
                                EPRTXTP.TX_TP_FINAL_PRICE,
                                EPRTXTP.TX_TP_PAID_STATUS,
                                EPRTXTP.TX_TP_DELETED,
                EPRCRED.RX_TX_CRED_REVERSED_DATE,
                EPRCRED.RX_TX_CRED_RETURNED_DATE
                                FROM EDW.F_RX_TX EPR    -- Encompasses PDX Classic and EPS Non-Symmetric Stores
                                INNER JOIN  EDW.D_PATIENT PT
                        ON ( EPR.CHAIN_ID = PT.CHAIN_ID AND EPR.RX_COM_ID = PT.RX_COM_ID )
            LEFT OUTER JOIN EDW.F_RX_TX_CRED EPRCRED
            ON EPR.CHAIN_ID = EPRCRED.CHAIN_ID
            AND EPR.RX_TX_ID = EPRCRED.RX_TX_ID
                        LEFT OUTER JOIN EDW.F_TX_TP EPRTXTP
                        ON ( EPR.CHAIN_ID = EPRTXTP.CHAIN_ID AND EPR.NHIN_STORE_ID = EPRTXTP.NHIN_STORE_ID AND EPR.RX_TX_ID = EPRTXTP.RX_TX_ID )
                        WHERE {% condition chain.chain_id %} EPR.CHAIN_ID {% endcondition %} -- Required for performance reasons and to avoid scanning all chain/store records
                          AND {% condition store.nhin_store_id %} EPR.NHIN_STORE_ID {% endcondition %}-- Required for performance reasons and to avoid scanning all chain/store records
                          -- [ERXDWPS-1690] Added store_number filter to avoid scanning all chain/store records and minimize data buffer for derived view.
                          AND epr.nhin_store_id in (select distinct nhin_store_id from edw.d_store
                                                      where source_system_id = 5
                                                        and {% condition chain.chain_id %} chain_id {% endcondition %}
                                                        and {% condition store.store_number %} store_number {% endcondition %})
                          AND {% condition chain.chain_id %} PT.CHAIN_ID {% endcondition %} -- Required for performance reasons and to avoid scanning all chain/store records
                          ) EPR
                        LEFT OUTER JOIN
                          (   SELECT
                            TX.CHAIN_ID,
                            TX.NHIN_STORE_ID,
                            RX.RX_NUMBER,
                            TX.RX_TX_TX_NUMBER,
                            RX.RX_STATUS,
                            TX.RX_TX_TX_STATUS,
                            TX.RX_TX_PARTIAL_FILL_STATUS,
                            TX.RX_TX_FILL_STATUS,
                            TX.RX_TX_POS_STATUS,
                            TX.RX_TX_DRUG_DISPENSED,
                            DECODE(TX.RX_TX_RETURNED_DATE,NULL,DECODE(TX.RX_TX_DRUG_DISPENSED,'G',NVL(TX.RX_TX_GENERIC_PRICE,0),NVL(TX.RX_TX_BRAND_PRICE,0)),NVL(TX.RX_TX_ORIGINAL_PRICE,0)) AS PRICE,
                            DECODE(TX.RX_TX_DRUG_DISPENSED,'G',NVL(TX.RX_TX_GENERIC_ACQUISITION_COST,0),NVL(TX.RX_TX_BRAND_ACQUISITION_COST,0)) AS ACQUISITION_COST,
                            TX.RX_TX_REPORTABLE_SALES_DATE,
                            TX.RX_TX_RETURNED_DATE,
                            NVL(TX.RX_TX_POS_OVERRIDDEN_NET_PAID,TXTP.TX_TP_FINAL_COPAY) AS NETPAID,
                            DECODE(TX.RX_TX_DRUG_DISPENSED,'G',NVL(TX.RX_TX_GENERIC_DISCOUNT, 0),NVL(TX.RX_TX_BRAND_DISCOUNT, 0)) AS DISCOUNT,
                            TX.RX_TX_TAX_AMOUNT,
                            TX.RX_TX_TP_BILL,
                            TX.RX_TX_REFILL_NUMBER,
                            TX.RX_TX_FILL_DATE,
                            TX.RX_TX_WILL_CALL_PICKED_UP_DATE,
                            TXTP.TX_TP_COUNTER,
                            TXTP.TX_TP_FINAL_COPAY,
                            TXTP.TX_TP_BALANCE_DUE_FROM_TP,
                            TXTP.TX_TP_WRITE_OFF_AMOUNT,
                            TXTP.TX_TP_SUBMIT_TYPE,
                            TXTP.TX_TP_PAID_STATUS,
                            TXTP.TX_TP_INACTIVE,
                            TXTP.TX_TP_FINAL_PRICE,
                            TX.RX_TX_DELETED,
                            RX.RX_DELETED,
                            RX.SOURCE_TIMESTAMP AS RX_SOURCE_TIMESTAMP,
                            TX.SOURCE_TIMESTAMP AS RX_TX_SOURCE_TIMESTAMP
                            FROM EDW.F_RX_TX_LINK TX
                            INNER JOIN EDW.F_RX RX
                            ON (  RX.CHAIN_ID = TX.CHAIN_ID AND RX.NHIN_STORE_ID = TX.NHIN_STORE_ID AND RX.RX_ID = TX.RX_ID  )
                            LEFT OUTER JOIN EDW.F_TX_TP_LINK TXTP
                            ON ( TX.CHAIN_ID = TXTP.CHAIN_ID AND TX.NHIN_STORE_ID = TXTP.NHIN_STORE_ID AND TX.RX_TX_ID = TXTP.RX_TX_ID AND TXTP.SOURCE_SYSTEM_ID = 4 )
                            WHERE {% condition chain.chain_id %} TX.CHAIN_ID {% endcondition %}   -- Required for performance reasons and to avoid scanning all chain/store records
                               AND {% condition store.nhin_store_id %} TX.NHIN_STORE_ID {% endcondition %}  -- Required for performance reasons and to avoid scanning all chain/store records
                               -- [ERXDWPS-1690] Added store_number filter to avoid scanning all chain/store records and minimize data buffer for derived view.
                               AND tx.nhin_store_id in (select distinct nhin_store_id from edw.d_store
                                                          where source_system_id = 5
                                                            and {% condition chain.chain_id %} chain_id {% endcondition %}
                                                            and {% condition store.store_number %} store_number {% endcondition %})
                               AND {% condition chain.chain_id %} RX.CHAIN_ID {% endcondition %}   -- Required for performance reasons and to avoid scanning all chain/store records
                               AND {% condition store.nhin_store_id %} RX.NHIN_STORE_ID {% endcondition %}  -- Required for performance reasons and to avoid scanning all chain/store records
                               -- [ERXDWPS-1690] Added store_number filter to avoid scanning all chain/store records and minimize data buffer for derived view.
                               AND rx.nhin_store_id in (select distinct nhin_store_id from edw.d_store
                                                          where source_system_id = 5
                                                            and {% condition chain.chain_id %} chain_id {% endcondition %}
                                                            and {% condition store.store_number %} store_number {% endcondition %})
                               AND {% condition chain.chain_id %} TXTP.CHAIN_ID {% endcondition %}   -- Required for performance reasons and to avoid scanning all chain/store records
                               AND {% condition store.nhin_store_id %} TXTP.NHIN_STORE_ID {% endcondition %}  -- Required for performance reasons and to avoid scanning all chain/store records
                               -- [ERXDWPS-1690] Added store_number filter to avoid scanning all chain/store records and minimize data buffer for derived view.
                               AND txtp.nhin_store_id in (select distinct nhin_store_id from edw.d_store
                                                            where source_system_id = 5
                                                              and {% condition chain.chain_id %} chain_id {% endcondition %}
                                                              and {% condition store.store_number %} store_number {% endcondition %})
                               AND TX.SOURCE_SYSTEM_ID = 4 --ERXLPS-2547
                               AND RX.SOURCE_SYSTEM_ID = 4 --ERXLPS-2547
                          ) EPS
                          ON ( EPR.CHAIN_ID = EPS.CHAIN_ID AND EPR.NHIN_STORE_ID = EPS.NHIN_STORE_ID AND EPR.RX_TX_RX_NUMBER = EPS.RX_NUMBER AND EPR.RX_TX_TX_NUMBER = EPS.RX_TX_TX_NUMBER AND EPR.TX_TP_COUNTER = EPS.TX_TP_COUNTER )
                ) SASD
                WHERE
                 SASD.RX_TX_RX_DELETED = 'N' AND
                 SASD.RX_TX_TX_DELETED = 'N' AND
                 SASD.PATIENT_SURVIVOR_ID IS NULL AND
                 SASD.PATIENT_UNMERGED_DATE IS NULL AND
                 SASD.TX_TP_DELETED = 'N' AND
                 SASD.RX_TX_FILL_STATUS IS NOT NULL AND
                 ( {% condition cash_filter %} 'NON-CASH' {% endcondition %} OR {% condition cash_filter %} 'BOTH' {% endcondition %} ) AND
                 (SASD.RX_TX_TP_BILL = 'Y' AND (SASD.TX_TP_INACTIVE = 'N')) AND
                 (SASD.RX_TX_RETURNED_DATE IS NOT NULL OR SASD.RX_TX_TX_STATUS IS NULL OR SASD.RX_TX_TX_STATUS <> 'H') AND
                 SASD.RX_TX_REPORTABLE_SALES_DATE IS NOT NULL
                 AND
                 (
                  (
                   {% condition date_to_use_filter %} 'REPORTABLE SALES' {% endcondition %}
                 AND
                 (SASD.RX_TX_RETURNED_DATE IS NULL OR TO_DATE(SASD.RX_TX_REPORTABLE_SALES_DATE) <> TO_DATE(SASD.RX_TX_RETURNED_DATE) ) AND
                 (
                       (
                             SASD.RX_TX_RETURNED_DATE IS NULL AND
                             {% condition sales_date_filter %} SASD.RX_TX_REPORTABLE_SALES_DATE {% endcondition %} AND
                             -- SASD.RX_TX_REPORTABLE_SALES_DATE BETWEEN TO_TIMESTAMP('2016-06-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS') AND TO_TIMESTAMP('2016-06-30 23:59:59', 'YYYY-MM-DD HH24:MI:SS') AND
                       ( SASD.TX_TP_PAID_STATUS IN (1, 2, 5) OR SASD.TX_TP_SUBMIT_TYPE='D')
                       )
                      OR
                       (
                             SASD.RX_TX_RETURNED_DATE IS NOT NULL AND
                       ( (SASD.TX_TP_PAID_STATUS IN  (1, 2, 4, 5) OR SASD.TX_TP_SUBMIT_TYPE='D') /*OR (SASD.TX_TP_PAID_STATUS  = 3 AND SASD.TX_TP_FINAL_PRICE IS NOT NULL)*/ ) AND
                              (
                                   (
                                          {% condition sales_date_filter %} SASD.RX_TX_RETURNED_DATE {% endcondition %}
                                          -- SASD.RX_TX_RETURNED_DATE BETWEEN TO_TIMESTAMP('2016-06-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS') AND TO_TIMESTAMP('2016-06-30 23:59:59', 'YYYY-MM-DD HH24:MI:SS')
                                   )
                                    OR
                                    (
                                        {% condition history_filter %} 'YES' {% endcondition %} AND
                                        {% condition sales_date_filter %} SASD.RX_TX_REPORTABLE_SALES_DATE {% endcondition %} AND
                                         -- SASD.RX_TX_REPORTABLE_SALES_DATE BETWEEN TO_TIMESTAMP('2016-06-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS') AND TO_TIMESTAMP('2016-06-30 23:59:59', 'YYYY-MM-DD HH24:MI:SS') AND
                                         SASD.RX_TX_RETURNED_DATE > ( SELECT MAX(CALENDAR_DATE) -- Includes future date credit return TXs
                                                                                  FROM
                                                                                  ( SELECT TO_DATE(DATEADD(DAY,SEQ4(),TRUNC(TO_DATE(TO_TIMESTAMP('2014-01-01 12:00:00')),'DAY'))) AS CALENDAR_DATE
                                                                                  FROM TABLE(GENERATOR(rowCount => 5112)) )
                                                                                  WHERE {% condition sales_date_filter %} CALENDAR_DATE {% endcondition %}
                                                                    )
                                        -- SASD.RX_TX_RETURNED_DATE > TO_TIMESTAMP('2016-06-30 23:59:59', 'YYYY-MM-DD HH24:MI:SS')
                                    )
                               )
                       )
                 )
                )
                OR
                (
                   {% condition date_to_use_filter %} 'SOLD' {% endcondition %}
                 AND
                 (SASD.RX_TX_RETURNED_DATE IS NULL OR TO_DATE(SASD.RX_TX_SOLD_DATE) <> TO_DATE(SASD.RX_TX_RETURNED_DATE) ) AND
                 (
                       (
                             SASD.RX_TX_RETURNED_DATE IS NULL AND
                             {% condition sales_date_filter %} SASD.RX_TX_SOLD_DATE {% endcondition %} AND
                             -- SASD.RX_TX_SOLD_DATE BETWEEN TO_TIMESTAMP('2016-06-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS') AND TO_TIMESTAMP('2016-06-30 23:59:59', 'YYYY-MM-DD HH24:MI:SS') AND
                       ( SASD.TX_TP_PAID_STATUS IN (1, 2, 5) OR SASD.TX_TP_SUBMIT_TYPE='D')
                       )
                      OR
                       (
                             SASD.RX_TX_RETURNED_DATE IS NOT NULL AND
                       ( (SASD.TX_TP_PAID_STATUS IN  (1, 2, 4, 5) OR SASD.TX_TP_SUBMIT_TYPE='D') /*OR (SASD.TX_TP_PAID_STATUS  = 3 AND SASD.TX_TP_FINAL_PRICE IS NOT NULL) */) AND
                              (
                                   (
                                          {% condition sales_date_filter %} SASD.RX_TX_RETURNED_DATE {% endcondition %}
                                          -- SASD.RX_TX_RETURNED_DATE BETWEEN TO_TIMESTAMP('2016-06-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS') AND TO_TIMESTAMP('2016-06-30 23:59:59', 'YYYY-MM-DD HH24:MI:SS')
                                   )
                                    OR
                                    (
                                        {% condition history_filter %} 'YES' {% endcondition %} AND
                                        {% condition sales_date_filter %} SASD.RX_TX_SOLD_DATE {% endcondition %} AND
                                         -- SASD.RX_TX_SOLD_DATE BETWEEN TO_TIMESTAMP('2016-06-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS') AND TO_TIMESTAMP('2016-06-30 23:59:59', 'YYYY-MM-DD HH24:MI:SS') AND
                                         SASD.RX_TX_RETURNED_DATE > ( SELECT MAX(CALENDAR_DATE) -- Includes future date credit return TXs
                                                                                  FROM
                                                                                  ( SELECT TO_DATE(DATEADD(DAY,SEQ4(),TRUNC(TO_DATE(TO_TIMESTAMP('2014-01-01 12:00:00')),'DAY'))) AS CALENDAR_DATE
                                                                                  FROM TABLE(GENERATOR(rowCount => 5112)) )
                                                                                  WHERE {% condition sales_date_filter %} CALENDAR_DATE {% endcondition %}
                                                                    )
                                        -- SASD.RX_TX_RETURNED_DATE > TO_TIMESTAMP('2016-06-30 23:59:59', 'YYYY-MM-DD HH24:MI:SS')
                                    )
                               )
                       )
                 )
                )
                )
                ) SALES
                WHERE SALES.RANK_TO_PICK_CORRECT_RX_TX_WHEN_DUPLICATED_IN_EPR = 1
          )
          SELECT
         EPR_RXTX.CHAIN_ID,
         EPR_RXTX.NHIN_STORE_ID,
         EPR_RXTX.SALE AS FINANCIAL_CATEGORY,
         EPR_RXTX.RX_COM_ID,
         EPR_RXTX.RX_TX_DISPENSED_DRUG_NDC,
         EPR_RXTX.RX_TX_RX_NUMBER,
         EPR_RXTX.RX_TX_TX_NUMBER,
         EPR_RXTX.RX_TX_REFILL_NUMBER,
         EPR_RXTX.PLAN,
         EPR_RXTX.RX_TX_RETURNED_DATE,
         EPR_RXTX.RX_TX_PRICE,
         EPR_RXTX.NET_SALES,
         EPR_RXTX.RX_TX_DISCOUNT_AMOUNT,
         EPR_RXTX.SPLIT_PRICE,
         EPR_RXTX.RX_TX_TAX_AMOUNT,
         EPR_RXTX.WRITE_OFF,
         EPR_RXTX.COUNTER,
         EPR_RXTX.TX_TP_SPLIT_BILL_FLAG,
         EPR_RXTX.FINAL_COPAY,
         CASE WHEN NVL(EPR_RXTX.COUNTER,-1) = EPR_RXTX.FIRST_COUNTER THEN EPR_RXTX.RX_TX_ACQUISITION_COST ELSE 0  END RX_TX_ACQUISITION_COST,
         EPR_RXTX.SUBMIT_TYPE,
         EPR_RXTX.RX_TX_REPORTABLE_SALES_DATE,
         EPR_RXTX.RX_TX_FILLED_DATE,
         EPR_RXTX.RX_TX_SOLD_DATE,
         EPR_RXTX.NET_DUE,
         EPR_RXTX.NET_PAID,
         EPR_RXTX.PATIENT_PAY_AMOUNT,
         1 AS RX_TX_CNT,
         CASE WHEN NVL(EPR_RXTX.COUNTER,-1) = EPR_RXTX.FIRST_COUNTER THEN 1 ELSE 0 END SCRIPT_COUNT
         FROM EPR_RXTX
                 WHERE SALE IN ('T/P - FILLED','CASH - FILLED')
                 AND {% condition history_filter %} 'YES' {% endcondition %}

         UNION

        SELECT
         EPR_RXTX.CHAIN_ID,
         EPR_RXTX.NHIN_STORE_ID,
         EPR_RXTX.CREDIT AS FINANCIAL_CATEGORY,
         EPR_RXTX.RX_COM_ID,
         EPR_RXTX.RX_TX_DISPENSED_DRUG_NDC,
         EPR_RXTX.RX_TX_RX_NUMBER,
         EPR_RXTX.RX_TX_TX_NUMBER,
         EPR_RXTX.RX_TX_REFILL_NUMBER,
         EPR_RXTX.PLAN,
         EPR_RXTX.RX_TX_RETURNED_DATE,
         EPR_RXTX.RX_TX_PRICE * -1 AS RX_TX_PRICE,
         EPR_RXTX.NET_SALES * -1 AS NET_SALES,
         EPR_RXTX.RX_TX_DISCOUNT_AMOUNT * -1 AS RX_TX_DISCOUNT_AMOUNT,
         EPR_RXTX.SPLIT_PRICE * -1 AS SPLIT_PRICE,
         EPR_RXTX.RX_TX_TAX_AMOUNT * -1 AS RX_TX_TAX_AMOUNT,
         EPR_RXTX.WRITE_OFF * -1 AS WRITE_OFF,
         EPR_RXTX.COUNTER,
         EPR_RXTX.TX_TP_SPLIT_BILL_FLAG,
         EPR_RXTX.FINAL_COPAY * -1 AS FINAL_COPAY,
         CASE WHEN NVL(EPR_RXTX.COUNTER,-1) = EPR_RXTX.FIRST_COUNTER THEN EPR_RXTX.RX_TX_ACQUISITION_COST ELSE 0  END RX_TX_ACQUISITION_COST,
         EPR_RXTX.SUBMIT_TYPE,
         EPR_RXTX.RX_TX_REPORTABLE_SALES_DATE,
         EPR_RXTX.RX_TX_FILLED_DATE,
         EPR_RXTX.RX_TX_SOLD_DATE,
         EPR_RXTX.NET_DUE * -1 AS NET_DUE,
         EPR_RXTX.NET_PAID * -1 AS NET_PAID,
         EPR_RXTX.PATIENT_PAY_AMOUNT * -1 AS PATIENT_PAY_AMOUNT,
         -1 AS RX_TX_CNT,
         CASE WHEN NVL(EPR_RXTX.COUNTER,-1) = EPR_RXTX.FIRST_COUNTER THEN -1 ELSE 0 END SCRIPT_COUNT
         FROM EPR_RXTX
                 WHERE CREDIT IN ('T/P - CREDIT','CASH - CREDIT')
                 AND {% condition history_filter %} 'YES' {% endcondition %}

        UNION

        SELECT
         EPR_RXTX.CHAIN_ID,
         EPR_RXTX.NHIN_STORE_ID,
         EPR_RXTX.NO_HISTORY_FINANCIAL_CATEGORY AS FINANCIAL_CATEGORY,
         EPR_RXTX.RX_COM_ID,
         EPR_RXTX.RX_TX_DISPENSED_DRUG_NDC,
         EPR_RXTX.RX_TX_RX_NUMBER,
         EPR_RXTX.RX_TX_TX_NUMBER,
         EPR_RXTX.RX_TX_REFILL_NUMBER,
         EPR_RXTX.PLAN,
         EPR_RXTX.RX_TX_RETURNED_DATE,
         EPR_RXTX.RX_TX_PRICE,
         EPR_RXTX.NET_SALES,
         EPR_RXTX.RX_TX_DISCOUNT_AMOUNT,
         EPR_RXTX.SPLIT_PRICE,
         EPR_RXTX.RX_TX_TAX_AMOUNT,
         EPR_RXTX.WRITE_OFF,
         EPR_RXTX.COUNTER,
         EPR_RXTX.TX_TP_SPLIT_BILL_FLAG,
         EPR_RXTX.FINAL_COPAY,
         CASE WHEN NVL(EPR_RXTX.COUNTER,-1) = EPR_RXTX.FIRST_COUNTER THEN EPR_RXTX.RX_TX_ACQUISITION_COST ELSE 0  END RX_TX_ACQUISITION_COST,
         EPR_RXTX.SUBMIT_TYPE,
         EPR_RXTX.RX_TX_REPORTABLE_SALES_DATE,
         EPR_RXTX.RX_TX_FILLED_DATE,
         EPR_RXTX.RX_TX_SOLD_DATE,
         EPR_RXTX.NET_DUE,
         EPR_RXTX.NET_PAID,
         EPR_RXTX.PATIENT_PAY_AMOUNT,
         1 AS RX_TX_CNT,
         CASE WHEN NVL(EPR_RXTX.COUNTER,0) = 0 THEN 1 ELSE 0 END SCRIPT_COUNT
         FROM EPR_RXTX
         WHERE {% condition history_filter %} 'NO' {% endcondition %};;
  }


  dimension: chain_id {
    type: number
    hidden: yes
    sql: ${TABLE}.CHAIN_ID ;; # primary key in source
  }

  dimension: nhin_store_id {
    type: number
    hidden: yes
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: financial_category {
    type: string
    label: "Financial Category"
    description: "Indicates the different type of Financial buckets such as 'Sales-Cash','Sales-T/P','Credit-Cash','Credit-T/P'"
    sql: ${TABLE}.FINANCIAL_CATEGORY ;;
  }

  dimension: rx_number {
    type: number
    label: "RX Number"
    group_label: "Prescription Transaction"
    description: "Prescription number"
    sql: ${TABLE}.RX_TX_RX_NUMBER ;;
    value_format: "####"
  }

  dimension: tx_number {
    type: number
    label: "TX Number"
    group_label: "Prescription Transaction"
    description: "Transaction number"
    sql: ${TABLE}.RX_TX_TX_NUMBER ;;
    value_format: "####"
  }

  dimension: refill_number {
    type: number
    label: "Refill Number"
    group_label: "Prescription Transaction"
    sql: ${TABLE}.RX_TX_REFILL_NUMBER ;;
  }

  dimension: store_dispensed_drug_ndc {
    hidden: yes
    sql: ${TABLE}.RX_TX_DISPENSED_DRUG_NDC ;;
  }

  dimension: plan {
    type: string
    label: "Plan"
    group_label: "Third Party"
    description: "Cash/Third Party Carriers"
    sql: ${TABLE}.PLAN ;;
  }

  dimension: rx_com_id {
    hidden: yes
    sql: ${TABLE}.RX_COM_ID;;
  }

  dimension: counter {
    type: number
    label: "Claim Billing Sequence"
    group_label: "Third Party"
    description: "Value indicating if a transaction third party record is for the primary, secondary, tertiary, etc."
    sql: ${TABLE}.COUNTER ;;
  }

  dimension: submit_type {
    type: string
    label: "Claim Submission Type"
    group_label: "Third Party"
    description: "Standard ,Rebill , Credit returned, Downtime and needs to transmitted and Downtime but has been transmitted "
    sql: ${TABLE}.SUBMIT_TYPE ;;
  }

  dimension: tx_tp_split_bill_flag {
    type: string
    label: "Split Bill Flag"
    description: "Split Bill Flag"
    sql: ${TABLE}.TX_TP_SPLIT_BILL_FLAG ;;
  }

  dimension_group: reportable_sales {
    label: "Reportable Sales"
    description: "Used to record the date when a TP script was adjudicated. For cash scripts, it is set when DE is completed"
    type: time
    timeframes: [time, date, week, month, month_num, year, quarter, quarter_of_year, yesno, hour_of_day, time_of_day, hour2, minute15, day_of_week, week_of_year, day_of_week_index, day_of_month]
    sql: ${TABLE}.RX_TX_REPORTABLE_SALES_DATE ;;
  }

  dimension_group: sold {
    label: "Sold"
    description: "Date/Time prescription was sold"
    type: time
    timeframes: [time, date, week, month, month_num, year, quarter, quarter_of_year, yesno, hour_of_day, time_of_day, hour2, minute15, day_of_week, week_of_year, day_of_week_index, day_of_month]
    sql: ${TABLE}.RX_TX_SOLD_DATE ;;
  }

  dimension_group: returned {
    label: "Returned"
    description: "Date/Time Credit Return on the transaction is performed"
    type: time
    timeframes: [time, date, week, month, month_num, year, quarter, quarter_of_year, yesno, hour_of_day, time_of_day, hour2, minute15, day_of_week, week_of_year, day_of_week_index, day_of_month]
    sql: ${TABLE}.RX_TX_RETURNED_DATE ;;
  }

  dimension_group: filled {
    label: "Filled"
    description: "Date prescription was filled"
    type: time
    timeframes: [time, date, week, month, month_num, year, quarter, quarter_of_year, yesno, hour_of_day, time_of_day, hour2, minute15, day_of_week, week_of_year, day_of_week_index, day_of_month]
    sql: ${TABLE}.RX_TX_FILLED_DATE ;;
  }

  measure: sum_acquisition_cost {
    label: "Acquisition Cost"
    group_label: "Pricing"
    description: "Represents the total acquisition cost of filled drug used on the prescription transaction record"
    type: sum
    sql: ${TABLE}.RX_TX_ACQUISITION_COST ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_price {
    label: "Price"
    group_label: "Pricing"
    description: "Total Price of prescription"
    type: sum
    sql: ${TABLE}.NET_SALES ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_sales {
    label: "Net Sales"
    group_label: "Pricing"
    description: "Total net sales of prescription"
    type: sum
    sql: ${TABLE}.NET_SALES ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_discount {
    label: "Discount"
    group_label: "Pricing"
    description: "Total Discount of prescription"
    type: sum
    sql: ${TABLE}.RX_TX_DISCOUNT_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_tax {
    label: "Tax"
    group_label: "Pricing"
    description: "Total Tax of prescription"
    type: sum
    sql: ${TABLE}.RX_TX_TAX_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_net_paid {
    label: "Patient Payment"
    group_label: "Pricing"
    description: "The overridden net pay amount rung up in the POS system, when it is a different amount than the patient net pay amount sent in the transaction request"
    type: sum
    sql: ${TABLE}.NET_PAID ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_split_price {
    label: "Split Price"
    group_label: "Third Party"
    description: "Total Price of prescription"
    type: sum
    sql: ${TABLE}.SPLIT_PRICE ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_write_off {
    label: "Write Off"
    group_label: "Third Party"
    description: "Difference between the submitted amount and the received balance plus the patient copay"
    type: sum
    sql: ${TABLE}.WRITE_OFF ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_final_copay {
    label: "Final Copay"
    group_label: "Third Party"
    description: "Final transaction third party patient copay. If the copay is overridden, this is the new amount as stated by the user. The third party copay is then populated"
    type: sum
    sql: ${TABLE}.FINAL_COPAY ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_net_due {
    label: "Net Due"
    group_label: "Third Party"
    description: "Amount owed by a third party"
    type: sum
    sql: ${TABLE}.NET_DUE ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_patient_pay {
    label: "Patient Pay Amount"
    group_label: "Third Party"
    description: "Amount owed by the patient"
    type: sum
    sql: ${TABLE}.PATIENT_PAY_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: count {
    label: "Total Claims"
    group_label: "Volume"
    description: "Total claim volume"
    type: sum
    sql: ${TABLE}.RX_TX_CNT ;;
    value_format: "#,##0"
  }

  measure: script_count {
    label: "Total Scripts"
    group_label: "Volume"
    description: "Total script volume"
    type: sum
    sql: ${TABLE}.SCRIPT_COUNT ;;
    value_format: "#,##0"
  }

############################################################ Templated Filters (Applied only for measures (so it could be applied in WHERE instead of HAVING clause #################################
  filter: history_filter {
    label: "HISTORY"
    description: "Includes both the sale and credit transaction for qualified transactions that have been cancelled or credit returned, when 'YES' is selected and default filter for this explore is set to show HISTORY. When 'NO' is selected, the report will only show the current information for the transaction"
    type: string
    suggestions: ["YES","NO"]
    full_suggestions: yes
  }

  filter: sales_date_filter {
    label: "REPORT PERIOD"
    description: "Starting and ending dates for the range of records you want to include"
    type: date
  }

  filter: cash_filter {
    label: "CASH, NON-CASH or BOTH"
    description: "Allows user to select CASH, NON-CASH or BOTH"
    type: string
    suggestions: ["CASH","NON-CASH","BOTH"]
    full_suggestions: yes
  }

  filter: date_to_use_filter {
    label: "DATE TO USE"
    description: "The DATE TO USE field determines what DATE FIELD is used to aggregate data, based on the time window specified"
    type: string
    suggestions: ["REPORTABLE SALES", "SOLD"]
    bypass_suggest_restrictions: yes
  }
}

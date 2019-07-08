view: mds_print_transaction_duplicate_count {
  # 1. This view file is specifically created for counting print transactions distinctly when there are multiple records in the print transaction table that should not be there due to MDS source system Defects
  # 2. The Query determines the difference between the print transactions dates, and determines when an allowed print occurred.
  # (NOTE: In order to properly choose the very first print transaction, the entire table needs to be queried everytime from the inner query. The time filter cannot be applied on the inner query)
  # 3. There are duplicate records in the PRINT_TRANSACTION table with the same TRANSACTION_ID so it is important when joining this to the PRINT_TRANSACTION table in the Explore to use the PRINT_TRANSACTION_ID
  # 4. IMPORTANT: The templated filters in the WHERE condition are important to performance of the query.
  # 5. The Description of the exposed count measure states that this solution is not designed for use with Medguides as there is no Document Days between use for Medguides.

  derived_table: {
    sql: WITH ALL_TRANSACTIONS AS
      (
        SELECT PT.PRINT_TRANSACTION_ID,
           P.PROGRAM_CODE,
           D.DOCUMENT_DAYS_BETWEEN,
           T.TRANSACTION_REQUEST_DATE,
           CASE WHEN T.TRANSACTION_RX_COM_ID IS NOT NULL THEN SHA2(CONCAT(T.CHAIN_ID,T.TRANSACTION_RX_COM_ID))
            ELSE SHA2(CONCAT(CONCAT(T.CHAIN_ID,T.NHIN_STORE_ID),T.TRANSACTION_PATIENT_CODE))
           END PATIENT_DE_IDENTIFIED
        FROM EDW.F_TRANSACTION T,
           EDW.F_PRINT_TRANSACTION PT,
           EDW.D_PROGRAM P,
           EDW.D_DOCUMENT D
        WHERE T.TRANSACTION_ID = PT.TRANSACTION_ID
          AND PT.PROGRAM_CODE = P.PROGRAM_CODE
          AND PT.DOCUMENT_IDENTIFIER = D.DOCUMENT_IDENTIFIER
          AND PT.PROGRAM_CODE = D.PROGRAM_CODE
          AND UPPER(PT.PRINT_TRANSACTION_PRINT_FLAG) = 'Y'
          AND UPPER(P.PROGRAM_CODE) != 'MEDGUIDE'
          AND {% condition chain.chain_id %} T.CHAIN_ID {% endcondition %}
          AND {% condition store.nhin_store_id %} T.NHIN_STORE_ID {% endcondition %}
          -- [ERXDWPS-1690] Added store_number filter to avoid scanning all chain/store records and minimize data buffer for derived view.
          AND t.nhin_store_id in (select distinct nhin_store_id from edw.d_store
                                    where source_system_id = 5
                                      and {% condition chain.chain_id %} chain_id {% endcondition %}
                                      and {% condition store.store_number %} store_number {% endcondition %})
          AND {% condition mds_program.program_code %} P.PROGRAM_CODE {% endcondition %}
          AND {% condition mds_program.program_start_date %} P.PROGRAM_START_DATE {% endcondition %}
          AND {% condition mds_program.program_end_date %} P.PROGRAM_END_DATE {% endcondition %}
          AND {% condition mds_program.program_deactivated_date %} P.PROGRAM_DEACTIVATED_DATE {% endcondition %}
          AND {% condition mds_program.program_publish_date %} P.PROGRAM_PUBLISH_DATE {% endcondition %}
          AND {% condition mds_program.program_service_type %} (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(P.PROGRAM_SERVICE_TYPE),'NULL') AND MC.EDW_COLUMN_NAME = 'PROGRAM_SERVICE_TYPE') {% endcondition %}
      )
      , UNIQUE_TRANSACTIONS AS
      (
        SELECT *
        FROM (
            SELECT PRINT_TRANSACTION_ID,
               PROGRAM_CODE,
               DOCUMENT_DAYS_BETWEEN,
               TRANSACTION_REQUEST_DATE,
               PATIENT_DE_IDENTIFIED,
               ROW_NUMBER() OVER(PARTITION BY PATIENT_DE_IDENTIFIED, PROGRAM_CODE, TO_DATE(TRANSACTION_REQUEST_DATE) ORDER BY TRANSACTION_REQUEST_DATE ASC) RNK
            FROM ALL_TRANSACTIONS
           )
        WHERE RNK = 1
         )
      , AGG_TRANSACTIONS AS
      (
        SELECT PATIENT_DE_IDENTIFIED,
           PROGRAM_CODE,
           ETL_MANAGER.FN_GET_ELIGIBLE_PRINT_DATES(LISTAGG(TO_DATE(TRANSACTION_REQUEST_DATE)||';'||NVL(DOCUMENT_DAYS_BETWEEN,1)||';') WITHIN GROUP (ORDER BY TO_DATE(TRANSACTION_REQUEST_DATE))) ELIGIBLE_PRINT_DATES
        FROM UNIQUE_TRANSACTIONS
        GROUP BY PATIENT_DE_IDENTIFIED, PROGRAM_CODE
      )
      , PRINT_TRANSACTIONS AS
      (
        SELECT U.PATIENT_DE_IDENTIFIED,
           U.PROGRAM_CODE,
           U.PRINT_TRANSACTION_ID,
           U.DOCUMENT_DAYS_BETWEEN,
           U.TRANSACTION_REQUEST_DATE
        FROM UNIQUE_TRANSACTIONS U,
           AGG_TRANSACTIONS A
        WHERE U.PATIENT_DE_IDENTIFIED = A.PATIENT_DE_IDENTIFIED
        AND U.PROGRAM_CODE = A.PROGRAM_CODE
        AND REGEXP_INSTR(A.ELIGIBLE_PRINT_DATES, TO_CHAR(TO_DATE(U.TRANSACTION_REQUEST_DATE))) != 0
      )
      SELECT PRINT_TRANSACTION_ID
      FROM PRINT_TRANSACTIONS
       ;;
  }

  dimension: print_transaction_distinct_id {
    label: "Print Transaction Distinct ID"
    # Primary Key for this view and Foreign Key to mds_print_transaction view
    description: "Unique ID number identifying a Print Transaction record in MDS"
    hidden: yes
    primary_key: yes
    type: number
    sql: ${TABLE}.PRINT_TRANSACTION_ID ;;
  }

  ################################################################################################## Measure #################################################################################################

  measure: count {
    label: "PE / POD Activity (Dups Removed)"
    description: "This is a count of activity from PDX-MS Pre Edit and / or PDX-MS Print On Demand occurences at Pharmacies actively utilizing PDX-MS Programs. This count includes logic that EXCLUDES Erroneous Duplicate Prints, as determined by the Programs Document Days Between Value and Print Transaction Request Dates in PDX-MS. This is not designed for use with Medguides as there is no Document Days between use for Medguides."
    type: count
    drill_fields: [
      mds_program.program_code,
      mds_program.program_description,
      mds_transaction.transaction_request_time,
      drug.drug_ndc,
      drug.drug_full_name,
      drug.drug_manufacturer,
      mds_print_transaction_duplicate_count.count
    ]
  }
}

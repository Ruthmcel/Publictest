view: bi_demo_chain_patient_summary_info {
  #1. This view is created to pull patient last visited store, fist fill date, last fill date for successfully adjudicated and sold transactions
  #2. This view will be used to list aggregate the drug name for each patient. Number of drug name list aggregated will be based on the input from user, Concatenate multiple drug names in single column
  #3. Consider not credit returned, valid fill status so that we can report valid drug consumed by patient
  #4. Modify chain_summary_patient_info for patient new to therapy - A patient filled a prescription in last complete calendar week/reporting period but has no prior prescription have same AFHS/GPI code in last one year. Transaction cancelled/credit returned shouldn't be considered.
  #5. Patient Last visited Store - last active transaction for a patient in the store and at minimum reportable sales date should be populated
  #6. Based on Discussion with team on 03/14/2017, Transactions should have reportable sales date, else the transaction can't be considered for any calculation in thos view


  derived_table: {
    sql: Select CHAIN_ID, RX_COM_ID,PAT_FIRST_FILL_DATE,PAT_LAST_FILLED_DATE,PAT_LAST_VISITED_STORE,PAT_LAST_VISITED_NHIN_STORE_ID,
               CASE
              when CHARINDEX (',,',MEDICATION_LIST,0) > 0 then Replace ((MEDICATION_LIST),',,',',')
              WHEN CHARINDEX (',',MEDICATION_LIST,0) = 1 then SUBSTRING(MEDICATION_LIST,2,LENGTH(MEDICATION_LIST))
              ELSE SUBSTRING (MEDICATION_LIST,1,LENGTH(MEDICATION_LIST)-1) END as CALC_MEDICATION_LIST ,
              NEW_THERAPY_DRUG_LIST , CASE when length(NEW_THERAPY_DRUG_LIST) > 0 then 'YES' ELSE 'NO' END as PAT_NEW_THERAPY_FLG
              ,TARGET_INDICATION
              from (

              Select CHAIN_ID, RX_COM_ID, MAX(PAT_LAST_VISITED_STORE) PAT_LAST_VISITED_STORE , MAX(RX_TX_FIRST_DATE) PAT_FIRST_FILL_DATE,
              MAX(RX_TX_LAST_FILL_DATE) PAT_LAST_FILLED_DATE, MAX(PAT_LAST_VISITED_NHIN_STORE_ID) PAT_LAST_VISITED_NHIN_STORE_ID,
              LISTAGG(DISTINCT (STORE_DRUG_NAME),', ') WITHIN GROUP (ORDER BY STORE_DRUG_NAME ASC)  MEDICATION_LIST,
              LISTAGG(DISTINCT (NEW_THERAPY_DRUG),', ') WITHIN GROUP (ORDER BY NEW_THERAPY_DRUG ASC)  NEW_THERAPY_DRUG_LIST
              ,LISTAGG(DISTINCT (DESCRIPTION),', ') WITHIN GROUP (ORDER BY DESCRIPTION ASC) TARGET_INDICATION
              from (

              Select CHAIN_ID, RX_COM_ID,RX_TX_FILL_DATE, CASE WHEN FIRST_FILL_DATE_RNK =1 then RX_TX_FILL_DATE END as RX_TX_FIRST_DATE,
              CASE WHEN DRUG_RNK =1 then NHIN_STORE_ID END as PAT_LAST_VISITED_NHIN_STORE_ID,
              CASE WHEN DRUG_RNK =1 then RX_TX_FILL_DATE END as RX_TX_LAST_FILL_DATE, CASE WHEN DRUG_RNK =1 then STORE_NUMBER END as PAT_LAST_VISITED_STORE,
              CaSE WHEN DRUG_RNK <=  {% parameter chain_patient_summary_info.aggregated_medication_name %} then STORE_DRUG_NAME END STORE_DRUG_NAME,
              DRUG_RNK,FIRST_FILL_DATE_RNK,

                Case when RX_TX_WILL_CALL_PICKED_UP_DATE_YYYYMMDD between {% date_start pat_new_to_therapy_date_period %} and {% date_end pat_new_to_therapy_date_period %} and sum(CALC_PAT_DRUG_ROWNUM) over (partition by CHAIN_ID,RX_COM_ID,GPI_THERAPY_CLASS order by RX_TX_FILL_DATE range between unbounded preceding and current row) =1
                then STORE_DRUG_NAME ||' (' ||RX_TX_FILL_DATE || ')' ELSE NULL END NEW_THERAPY_DRUG,RX_TX_REFILL_NUMBER,
                 Case when RX_TX_WILL_CALL_PICKED_UP_DATE_YYYYMMDD between {% date_start pat_new_to_therapy_date_period %} and {% date_end pat_new_to_therapy_date_period %} and sum(CALC_PAT_DRUG_ROWNUM) over (partition by CHAIN_ID,RX_COM_ID,GPI_THERAPY_CLASS order by RX_TX_FILL_DATE range between unbounded preceding and current row) =1
                 THEN DESCRIPTION ELSE NULL END DESCRIPTION
                      from (
              Select CHAIN_ID,RX_COM_ID,STORE_NUMBER,RX_TX_FILL_DATE,STORE_DRUG_NAME,NHIN_STORE_ID,DRUG_RNK,FIRST_FILL_DATE_RNK,
              RX_TX_REFILL_NUMBER, RX_TX_WILL_CALL_PICKED_UP_DATE_YYYYMMDD, DESCRIPTION,GPI_THERAPY_CLASS,
              Case when RX_TX_FILL_DATE between DATEADD(year,-1,{% date_start pat_new_to_therapy_date_period %}) and {% date_end pat_new_to_therapy_date_period %} then PAT_DRUG_ROWNUM else 0 end CALC_PAT_DRUG_ROWNUM
                  from (

                  SELECT
                  PAT.CHAIN_ID,
                  PAT.RX_COM_ID,
                  STR.STORE_NUMBER,
                  TO_DATE(TX.RX_TX_FILL_DATE) RX_TX_FILL_DATE,
                  SDRG.STORE_DRUG_NAME,
                  TX.NHIN_STORE_ID,
                  ROW_NUMBER() OVER (PARTITION BY PAT.CHAIN_ID,PAT.RX_COM_ID ORDER BY TO_DATE(TX.RX_TX_REPORTABLE_SALES_DATE) DESC NULLs LAST) DRUG_RNK,
                  ROW_NUMBER() OVER (PARTITION BY PAT.CHAIN_ID,PAT.RX_COM_ID order by TO_DATE(TX.RX_TX_REPORTABLE_SALES_DATE) ASC NULLs LAST) FIRST_FILL_DATE_RNK,
                  ROW_NUMBER() OVER (PARTITION BY PAT.CHAIN_ID,RX_COM_ID,
                  DECODE(STORE_DRUG_AHFS_THERAPEUTIC_CLASS, NULL, SUBSTR(STORE_DRUG_GPI,1,6), STORE_DRUG_AHFS_THERAPEUTIC_CLASS )
                  Order by TX.RX_TX_FILL_DATE DESC NULLS LAST) PAT_DRUG_ROWNUM,
                  DECODE(STORE_DRUG_AHFS_THERAPEUTIC_CLASS, NULL, SUBSTR(STORE_DRUG_GPI,1,6), STORE_DRUG_AHFS_THERAPEUTIC_CLASS ) as GPI_THERAPY_CLASS,
                  RX_TX_REFILL_NUMBER,
                  RX_TX_WILL_CALL_PICKED_UP_DATE_YYYYMMDD,
                  CASE WHEN GPI_DISEASE_CROSS_REF.DESCRIPTION IS NULL THEN 'NOT AVAILABLE' ELSE GPI_DISEASE_CROSS_REF.DESCRIPTION END DESCRIPTION

              FROM
                  EDW.F_RX_TX_LINK TX

              JOIN
                  EDW.F_RX RX
              ON
                  TX.CHAIN_ID = RX.CHAIN_ID
              AND TX.NHIN_STORE_ID = RX.NHIN_STORE_ID
              AND TX.RX_ID = RX.RX_ID
              JOIN
                  EDW.D_STORE_PATIENT PAT
              ON
                  RX.chain_id = PAT.chain_id
              AND RX.nhin_store_id = PAT.nhin_store_id
              AND RX.rx_patient_id = PAT.patient_id
              JOIN
                  EDW.D_STORE_DRUG SDRG
              ON
                  SDRG.chain_id = TX.chain_id
              AND SDRG.nhin_store_id= TX.nhin_store_id
              AND SDRG.drug_id = TX.RX_TX_DRUG_DISPENSED_ID --ERXLPS-1351 Search and replace all view files to use EDW materialized columns from RX_TX_LINK
              JOIN
                   EDW.D_STORE STR
                   on STR.CHAIN_ID = TX.CHAIN_ID and STR.NHIN_STORE_ID = TX.NHIN_STORE_ID and STR.SOURCE_SYSTEM_ID = 5
               LEFT JOIN
               (SELECT DISEASE_CODE,  GPI,
                        DESCRIPTION,
                        MNEMONIC,
                        DURATION,
                        ROW_NUMBER() OVER (PARTITION BY GPI ORDER BY  DURATION DESC, INDICATION_CODE ASC , DESCRIPTION ASC) GPI_RNK
                  FROM EDW.D_GPI_DISEASE_CROSS_REF) GPI_DISEASE_CROSS_REF
                  on SDRG.STORE_DRUG_GPI = GPI_DISEASE_CROSS_REF.GPI and GPI_DISEASE_CROSS_REF.GPI_RNK = 1

              WHERE    TX.CHAIN_ID IN (SELECT DISTINCT CHAIN_ID FROM REPORT_TEMP.BI_DEMO_CHAIN_STORE_MAPPING WHERE {% condition bi_demo_store.bi_demo_nhin_store_id %} NHIN_STORE_ID_BI_DEMO_MAPPING {% endcondition %})   -- Required for performance reasons and to avoid scanning all chain/store records
                      AND RX.CHAIN_ID IN (SELECT DISTINCT CHAIN_ID FROM REPORT_TEMP.BI_DEMO_CHAIN_STORE_MAPPING WHERE {% condition bi_demo_store.bi_demo_nhin_store_id %} NHIN_STORE_ID_BI_DEMO_MAPPING {% endcondition %})   -- Required for performance reasons and to avoid scanning all chain/store records
                      AND PAT.CHAIN_ID IN (SELECT DISTINCT CHAIN_ID FROM REPORT_TEMP.BI_DEMO_CHAIN_STORE_MAPPING WHERE {% condition bi_demo_store.bi_demo_nhin_store_id %} NHIN_STORE_ID_BI_DEMO_MAPPING {% endcondition %})   -- Required for performance reasons and to avoid scanning all chain/store records
                      AND SDRG.CHAIN_ID IN (SELECT DISTINCT CHAIN_ID FROM REPORT_TEMP.BI_DEMO_CHAIN_STORE_MAPPING WHERE {% condition bi_demo_store.bi_demo_nhin_store_id %} NHIN_STORE_ID_BI_DEMO_MAPPING {% endcondition %})   -- Required for performance reasons and to avoid scanning all chain/store records
                      AND STR.CHAIN_ID IN (SELECT DISTINCT CHAIN_ID FROM REPORT_TEMP.BI_DEMO_CHAIN_STORE_MAPPING WHERE {% condition bi_demo_store.bi_demo_nhin_store_id %} NHIN_STORE_ID_BI_DEMO_MAPPING {% endcondition %})   -- Required for performance reasons and to avoid scanning all chain/store records
              AND tx.RX_TX_FILL_STATUS IS NOT NULL
              AND TX.RX_TX_REPORTABLE_SALES_DATE IS NOT NULL
              AND TX.RX_TX_RETURNED_DATE IS NULL
              AND TX.rx_tx_tx_deleted = 'N'
              AND RX.rx_deleted = 'N'
              AND SDRG.STORE_DRUG_DELETED = 'N'
              AND TX.source_system_id = 4
              AND RX.source_system_id = 4
              AND SDRG.source_system_id = 4
              AND PAT.source_system_id = 4
               ) a
                ) aa
                ) b

               GROUP by CHAIN_ID, RX_COM_ID )pat_summary_info
               ;;
  }

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    type: number
    sql: ${chain_id} ||'@'|| ${rx_com_id} ;; #ERXLPS-1649
  }

  #################################################################################################### Foreign Key References ####################################################################################
  dimension: chain_id {
    type: number
    hidden: yes
    # primary key in source
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: rx_com_id {
    type: number
    hidden: yes
    sql: ${TABLE}.RX_COM_ID ;;
  }

  dimension: pat_last_visited_store_id {
    type: number
    #hidden: true
    label: "Store Patient Last Visited Store"
    description: "Patient Last Visited Store"
    sql: ${TABLE}.PAT_LAST_VISITED_STORE ;;
  }

  dimension: pat_last_visited_nhin_store_id {
    type: number
    hidden: yes
    label: "Store Patient Last Visited NHIN Store"
    description: "Patient Last Visited NHIN Store"
    sql: ${TABLE}.PAT_LAST_VISITED_NHIN_STORE_ID ;;
  }

  measure: last_filled_date {
    label: "Store Patient Last Filled Date"
    description: "Date prescription was last filled"
    type: string
    sql: MAX(${TABLE}.PAT_LAST_FILLED_DATE) ;;
  }

  measure: first_fill_date {
    label: "Store Patient First Filled Date"
    description: "Date prescription was first filled"
    type: string
    sql: MAX(${TABLE}.PAT_FIRST_FILL_DATE) ;;
  }

  #[ERXLPS-794] : dimensions added for referenced in sales view to get fiscal dates for these dimensions
  dimension: last_filled_reference {
    label: "Store Patient Last Filled"
    description: "Date prescription was last filled"
    hidden:  yes
    sql: ${TABLE}.PAT_LAST_FILLED_DATE ;;
  }

  dimension: first_fill_reference {
    label: "Store Patient First Filled"
    description: "Date prescription was first filled"
    hidden:  yes
    sql: ${TABLE}.PAT_FIRST_FILL_DATE ;;
  }

  measure: medication_list {
    type: string
    label: "Medication List"
    description: "Combines Drug names with comma delimited"
    sql: MAX(${TABLE}.CALC_MEDICATION_LIST) ;;
  }

  measure: target_indication_list {
    type: string
    label: "Store Patient New to Therapy - Target Indication List"
    description: "Display Patient New to Therapy Target Indication list with comma delimited"
    sql: MAX(${TABLE}.TARGET_INDICATION) ;;
  }

  measure: pat_new_therapy_drug_with_filldate {
    type: string
    label: "Store Patient New to Therapy - Drug with Filled Date"
    description: "Display Patient New to Therapy Drug with Filled Date with comma delimited"
    sql: MAX(${TABLE}.NEW_THERAPY_DRUG_LIST) ;;
  }

  dimension: pat_new_therapy_flag {
    type: string
    label: "Store Patient New to Therapy Flag"
    description: "Yes/No Flag Indicates a Patient New to Therapy or Not"
    sql: ${TABLE}.PAT_NEW_THERAPY_FLG ;;
    suggestions: ["YES", "NO"]
    full_suggestions: yes
  }

  measure: days_since_last_activity {
    type: number
    label: "Days Since Last Activity"
    description: "Days Since Last Activity"
    sql: DATEDIFF(DAY,${last_filled_date},CURRENT_TIMESTAMP) ;;
  }

  ############################################################ Templated Filters (Applied only for measures (so it could be applied in WHERE instead of HAVING clause #################################
  filter: aggregated_medication_name {
    label: "Medication List Drug Count"
    description: "Aggregates Medication name based on the input per patient at chain level. Default value will be 3"
    type: string
    suggestions: [
      "1",
      "2",
      "3",
      "4",
      "5",
      "6",
      "7",
      "8",
      "9"
    ]
    default_value: "3"
    full_suggestions: yes
  }

  filter: pat_new_to_therapy_date_period {
    label: "Store Patient New to Therapy Date Period"
    description: "Patient New to Therapy Date Period"
    type: date
    default_value: "1 week ago for 1 week"
  }
}

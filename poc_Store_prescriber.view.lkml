view: poc_store_prescriber {

  derived_table: {
    sql:

                            SELECT
                                pres.chain_id,
                                pres.NHIN_STORE_ID,
                                pres.EDW_PRESCRIBER_IDENTIFIER,
                                pres.store_prescriber_npi_number,
                                pres.PRESCRIBER_DEA_NUMBER,
                                pres.PRESCRIBER_FEDERAL_TAX_NUMBER,
                                pres.PRESCRIBER_DEACTIVATE_DATE,
                                pres.STORE_PRESCRIBER_CLINIC_LINK_ID,
                                pres.STORE_PRESCRIBER_CLINIC_LINK_PRIMARY_CLINIC_FLAG,
                                pres.STORE_PRESCRIBER_CLINIC_LINK_LOCATION,
                                pres.STORE_PRESCRIBER_DAW_CODE,
                                pres.STORE_PRESCRIBER_SPECIALTY_CODE,
                                pres.STORE_PRESCRIBER_TAXONOMY_CODE,
                                pres.STORE_PRESCRIBER_STATE_STATE,
                                pres.CLINIC_NAME,
                                --MIN(RX_TX_WILL_CALL_PICKED_UP_DATE) MIN_SOLD,
                                MIN( RX_TX_WILL_CALL_PICKED_UP_DATE )  OVER ( PARTITION BY EDW_PRESCRIBER_IDENTIFIER order by RX_TX_WILL_CALL_PICKED_UP_DATE nulls last )  MIN_SOLD_DATE,
                                count( distinct STORE_PRESCRIBER_CLINIC_LINK_ID )  OVER ( PARTITION BY EDW_PRESCRIBER_IDENTIFIER )  PRESC_CLINIC_COUNT,
                                count( distinct pres.NHIN_STORE_ID )  OVER ( PARTITION BY EDW_PRESCRIBER_IDENTIFIER )  PRESC_STORES_COUNT,
                                count( distinct STORE_PRESCRIBER_CLINIC_LINK_PRIMARY_CLINIC_FLAG )  OVER ( PARTITION BY EDW_PRESCRIBER_IDENTIFIER )  PRIMARY_CLINIC_COUNT,
                                ROW_NUMBER()   OVER( PARTITION BY pres.CHAIN_ID,pres.NHIN_STORE_ID,pres.STORE_PRESCRIBER_CLINIC_LINK_ID order by pres.SOURCE_TIMESTAMP desc ) ROW_NUMBER
                            FROM
                                (
                                    SELECT distinct
                                        spcl.chain_id,
                                        spcl.NHIN_STORE_ID,
                                        CASE
                                            WHEN p.store_prescriber_npi_number IS NOT NULL
                                            AND LENGTH(trim(p.store_prescriber_npi_number)) > 0
                                            THEN trim(UPPER(p.store_prescriber_npi_number))
                                            WHEN p.store_prescriber_npi_number IS NULL
                                            AND (spcl.STORE_PRESCRIBER_CLINIC_LINK_DEA_NUMBER IS NOT NULL
                                                AND LENGTH(trim(spcl.STORE_PRESCRIBER_CLINIC_LINK_DEA_NUMBER)) > 0)
                                            THEN trim(UPPER(spcl.STORE_PRESCRIBER_CLINIC_LINK_DEA_NUMBER))
                                            WHEN p.store_prescriber_npi_number IS NULL
                                            AND spcl.STORE_PRESCRIBER_CLINIC_LINK_DEA_NUMBER IS NULL
                                            AND (p.STORE_PRESCRIBER_DEA_NUMBER IS NOT NULL
                                                AND LENGTH(trim(p.STORE_PRESCRIBER_DEA_NUMBER)) > 0)
                                            THEN trim(UPPER(p.STORE_PRESCRIBER_DEA_NUMBER))
                                            WHEN p.store_prescriber_npi_number IS NULL
                                            AND spcl.STORE_PRESCRIBER_CLINIC_LINK_DEA_NUMBER IS NULL
                                            AND p.STORE_PRESCRIBER_DEA_NUMBER IS NULL
                                            AND (c.CLINIC_DEA_NUMBER IS NOT NULL
                                                AND LENGTH(trim(c.CLINIC_DEA_NUMBER)) > 0)
                                            THEN trim(UPPER(c.CLINIC_DEA_NUMBER))
                                            WHEN p.store_prescriber_npi_number IS NULL
                                            AND spcl.STORE_PRESCRIBER_CLINIC_LINK_DEA_NUMBER IS NULL
                                            AND p.STORE_PRESCRIBER_DEA_NUMBER IS NULL
                                            AND c.CLINIC_DEA_NUMBER IS NULL
                                            AND (s.STORE_PRESCRIBER_STATE_STATE_LICENSE_NUMBER IS NOT NULL
                                                AND LENGTH(trim(s.STORE_PRESCRIBER_STATE_STATE_LICENSE_NUMBER)) > 0)
                                            THEN trim(UPPER(s.STORE_PRESCRIBER_STATE_STATE)) || '+' || trim(UPPER
                                                (s.STORE_PRESCRIBER_STATE_STATE_LICENSE_NUMBER))
                                            WHEN p.store_prescriber_npi_number IS NULL
                                            AND spcl.STORE_PRESCRIBER_CLINIC_LINK_DEA_NUMBER IS NULL
                                            AND p.STORE_PRESCRIBER_DEA_NUMBER IS NULL
                                            AND c.CLINIC_DEA_NUMBER IS NULL
                                            AND s.STORE_PRESCRIBER_STATE_STATE_LICENSE_NUMBER IS NULL
                                            AND ((p.store_prescriber_last_name IS NOT NULL
                                                    OR  p.store_prescriber_first_name IS NOT NULL
                                                    OR  p.store_prescriber_middle_name IS NOT NULL)
                                                AND LENGTH(trim((NVL(p.store_prescriber_last_name,'') || NVL
                                                    (p.store_prescriber_first_name,'') || NVL(p.store_prescriber_middle_name,''
                                                    )))) > 0 )
                                            THEN trim(trim(UPPER(NVL(p.store_prescriber_last_name,''))) || '+' || trim(UPPER
                                                (NVL (p.store_prescriber_first_name,''))) || '+' || trim(UPPER(NVL
                                                (p.store_prescriber_middle_name,''))))
                                            ELSE 'ERX-Hierarchy-Exhausted'
                                        END :: VARCHAR(255) AS EDW_PRESCRIBER_IDENTIFIER,
                                        p.store_prescriber_npi_number,
                                        CASE
                                            WHEN (spcl.STORE_PRESCRIBER_CLINIC_LINK_DEA_NUMBER IS NOT NULL
                                                AND LENGTH(trim(spcl.STORE_PRESCRIBER_CLINIC_LINK_DEA_NUMBER)) > 0)
                                            THEN trim(UPPER(spcl.STORE_PRESCRIBER_CLINIC_LINK_DEA_NUMBER))
                                            WHEN (p.STORE_PRESCRIBER_DEA_NUMBER IS NOT NULL
                                                AND LENGTH(trim(p.STORE_PRESCRIBER_DEA_NUMBER)) > 0)
                                            THEN trim(UPPER(p.STORE_PRESCRIBER_DEA_NUMBER))
                                            WHEN (c.CLINIC_DEA_NUMBER IS NOT NULL
                                                AND LENGTH(trim(c.CLINIC_DEA_NUMBER)) > 0)
                                            THEN trim(UPPER(c.CLINIC_DEA_NUMBER))
                                            ELSE NULL
                                        END PRESCRIBER_DEA_NUMBER,
                                        CASE
                                            WHEN STORE_PRESCRIBER_CLINIC_LINK_FEDERAL_TAX_NUMBER IS NOT NULL
                                            THEN STORE_PRESCRIBER_CLINIC_LINK_FEDERAL_TAX_NUMBER
                                            WHEN STORE_PRESCRIBER_FEDERAL_TAX_NUMBER IS NOT NULL
                                            THEN STORE_PRESCRIBER_FEDERAL_TAX_NUMBER
                                            ELSE NULL
                                        END AS PRESCRIBER_FEDERAL_TAX_NUMBER,
                                        CASE
                                            WHEN STORE_PRESCRIBER_CLINIC_LINK_DEACTIVATE_DATE IS NOT NULL
                                            THEN STORE_PRESCRIBER_CLINIC_LINK_DEACTIVATE_DATE
                                            WHEN STORE_PRESCRIBER_DEACTIVATE_DATE IS NOT NULL
                                            THEN STORE_PRESCRIBER_DEACTIVATE_DATE
                                            ELSE NULL
                                        END PRESCRIBER_DEACTIVATE_DATE,
                                        STORE_PRESCRIBER_CLINIC_LINK_ID,
                                        STORE_PRESCRIBER_CLINIC_LINK_PRIMARY_CLINIC_FLAG,
                                        STORE_PRESCRIBER_CLINIC_LINK_LOCATION,
                                        STORE_PRESCRIBER_DAW_CODE,
                                        STORE_PRESCRIBER_SPECIALTY_CODE,
                                        STORE_PRESCRIBER_TAXONOMY_CODE,
                                        STORE_PRESCRIBER_STATE_STATE,
                                        CLINIC_NAME,
                                        spcl.SOURCE_TIMESTAMP
                                    FROM
                                        edw.d_store_prescriber_clinic_link spcl
                                    INNER JOIN
                                        edw.d_store_prescriber p
                                    ON
                                        spcl.chain_id = p.chain_id
                                    AND spcl.nhin_store_id = p.nhin_store_id
                                    AND spcl.STORE_PRESCRIBER_ID = p.store_prescriber_id
                                    INNER JOIN
                                        edw.d_clinic c
                                    ON
                                        spcl.chain_id = c.chain_id
                                    AND spcl.nhin_store_id = c.nhin_store_id
                                    AND spcl.clinic_id = c.clinic_id
                                    LEFT OUTER JOIN
                                        edw.d_store_prescriber_state s
                                    ON
                                        p.chain_id = s.chain_id
                                    AND p.nhin_store_id = s.nhin_store_id
                                    AND p.store_prescriber_id = s.store_prescriber_id ) Pres
                            LEFT JOIN
                                (Select CHAIN_ID,NHIN_STORE_ID,RX_TX_PRESC_CLINIC_LINK_ID, MIN(RX_TX_WILL_CALL_PICKED_UP_DATE) RX_TX_WILL_CALL_PICKED_UP_DATE from  EDW.F_RX_TX_LINK
                                GROUP BY CHAIN_ID,NHIN_STORE_ID,RX_TX_PRESC_CLINIC_LINK_ID
                                )RX_TX
                            ON
                                Pres.CHAIN_ID = RX_TX.CHAIN_ID
                            AND Pres.NHIN_STORE_ID = RX_TX.NHIN_STORE_ID
                            AND Pres.STORE_PRESCRIBER_CLINIC_LINK_ID = RX_TX.RX_TX_PRESC_CLINIC_LINK_ID
                            ;;
            }

dimension: unique_key {
    hidden: yes
    primary_key: yes
    sql: ${chain_id} || '@' || ${nhin_store_id}  || '@' || ${prescriber_clinic_id}  ;;
  }

  dimension: chain_id {
   # hidden: yes
    type: number
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
   # hidden: yes
    type: number
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: unique_prescriber_identifier {
   hidden: yes
    label: "Prescriber ID"
    type: string
    sql: ${TABLE}.EDW_PRESCRIBER_IDENTIFIER ;;
  }

  dimension: unique_presc_row_num {
    hidden: yes
    type: string
    sql: ${TABLE}.ROW_NUMBER ;;
  }

  dimension: prescriber_npi_number {
    # hidden: yes
    label: "Prescriber NPI"
    type: string
    sql: ${TABLE}.store_prescriber_npi_number ;;
  }

  dimension: prescriber_dea_number {
    # hidden: yes
    label: "DEA"
    type: string
    sql: ${TABLE}.PRESCRIBER_DEA_NUMBER ;;
  }

  dimension: store_prescriber_federal_number {
    # hidden: yes
    label: "Federal Number"
    type: number
    sql: ${TABLE}.PRESCRIBER_FEDERAL_TAX_NUMBER ;;
  }

  dimension: prescriber_deactivate_date {
    # hidden: yes
    label: "Deactivate Date"
    type: date
    sql: ${TABLE}.PRESCRIBER_DEACTIVATE_DATE ;;
  }

  dimension: prescriber_clinic_id {
    # hidden: yes
    label: "Prescriber Clinic ID"
    type: number
    sql: ${TABLE}.STORE_PRESCRIBER_CLINIC_LINK_ID ;;
  }

  dimension: prescriber_primary_clinic_flag {
    # hidden: yes
    label: "Primary Clinic Flag"
    type: string
    sql: ${TABLE}.STORE_PRESCRIBER_CLINIC_LINK_PRIMARY_CLINIC_FLAG ;;
  }

  dimension: prescriber_clinic_location {
    # hidden: yes
    label: "Clinic Location"
    type: string
    sql: ${TABLE}.STORE_PRESCRIBER_CLINIC_LINK_LOCATION ;;
  }

  dimension: prescriber_daw_code {
    # hidden: yes
    label: "DAW Code"
    type: string
    sql: ${TABLE}.STORE_PRESCRIBER_DAW_CODE ;;
  }

  dimension: prescriber_speciality_code {
    # hidden: yes
    label: "Speciality Code"
    type: string
    sql: ${TABLE}.STORE_PRESCRIBER_SPECIALTY_CODE ;;
  }

  dimension: prescriber_taxonomy_code {
    # hidden: yes
    label: "Taxonomy Code"
    type: string
    sql: ${TABLE}.STORE_PRESCRIBER_TAXONOMY_CODE ;;
  }

  dimension: prescriber_state {
    # hidden: yes
    label: "Prescriber State"
    type: string
    sql: ${TABLE}.STORE_PRESCRIBER_STATE_STATE ;;
  }

  dimension: clinic_name {
    # hidden: yes
    label: "Clinic Name"
    type: string
    sql: ${TABLE}.CLINIC_NAME ;;
  }

  dimension: min_sold_date {
    # hidden: yes
    label: "Min Sold Date"
    type: date
    sql: ${TABLE}.MIN_SOLD_DATE ;;
  }

  dimension: presc_clinic_count {
    # hidden: yes
    label: "Prescriber Clinic Count"
    type: number
    sql: ${TABLE}.PRESC_CLINIC_COUNT ;;
  }

  dimension: presc_stores_count {
    # hidden: yes
    label: "Prescriber Stores Count"
    type: number
    sql: ${TABLE}.PRESC_STORES_COUNT ;;
  }


  dimension: primary_clinic_count {
    # hidden: yes
    label: "Primary Clinic Count"
    type: number
    sql: ${TABLE}.PRIMARY_CLINIC_COUNT ;;
  }


 }

view: poc_unique_prescriber {
  derived_table: {
            sql:         SELECT DISTINCT

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
                                        STORE_PRESCRIBER_LAST_NAME,
                                        STORE_PRESCRIBER_FIRST_NAME
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
                                    AND p.store_prescriber_id = s.store_prescriber_id ;;
  }

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    sql: ${unique_prescriber_identifier}  ;;
  }

  dimension: unique_prescriber_identifier {
    # hidden: yes
    label: "Prescriber ID"
    type: string
    sql: ${TABLE}.EDW_PRESCRIBER_IDENTIFIER ;;
  }

  dimension: prescriber_last_name {
    # hidden: yes
    label: "Prescriber Last Name"
    type: string
    sql: ${TABLE}.STORE_PRESCRIBER_LAST_NAME ;;
  }

  dimension: prescriber_first_name {
    # hidden: yes
    label: "Prescriber First Name"
    type: string
    sql: ${TABLE}.STORE_PRESCRIBER_FIRST_NAME ;;
  }

   }
